[Back to Overview](/README.md) or [Go to Next Step](/docs/step_2.md)
<br />  
<br />  
At this stage it is assumed that you have Docker installed in the host machine. In this tutorial we'll be running Docker on a [Linux Mint](https://linuxmint.com/) distribution. It's not the purpose of this project to go over the necessary steps to install Docker in the host machine. Please check out the [documentation](https://docs.docker.com/engine/install/). Run ```docker --version``` to check the version:

<a name="step_1_docker_version"><p align="center"><img src="/docs/images/step_1_docker_version.PNG" alt="Docker version" width="390" height="35"/></p></a>

# Build an Image Using Dockerfile <a name="build_an_image_using_dockerfile"></a>

To be able to start using Docker containers we must first have images to work with. Images in Docker can be created from scratch, pulled from a registry ([Docker Hub](https://hub.docker.com/) is Docker's official cloud-based registry), or be built from a **Dockerfile**. In this tutorial we'll be using the Dockerfile approach.

As discussed in the [documentation](https://docs.docker.com/engine/reference/builder/), a Dockerfile is a text document that contains all the commands a user could call on the command line to assemble an image. Below you can see what one of the Dockerfiles we'll be using looks like:

```bash
# Use latest Jenkins image
FROM jenkins/jenkins:lts

# Meta-data
LABEL maintainer="FirstName LastName <email@email.com>" \
      description="If you want a description."

# Change to root user to be able to run commands
USER root

# Run update and install Docker client
RUN apt-get update && \
apt-get -y install && \
curl -fsSL https://get.docker.com -o get-docker.sh && \
sh get-docker.sh

# Add 'jenkins' user to the 'docker' group
RUN usermod -aG Docker jenkins

# Revert back to the jenkins user
USER jenkins
```

Here we are starting with the [Jenkins base image](https://hub.docker.com/r/jenkins/jenkins), adding some metadata, then finally setting up how we want our new image to look like. The new image is what we'll be using to create a container which runs Jenkins.

Notice that from ```USER root``` onwards there are commands used to install Docker client. An image with these instructions will create containers inheriting from the Jenkins base image while also having Docker client installed. Remember that Jenkins is where the testing instructions are carried out, one of which is the creation of a Python container that will test the code coming from GitHub. Therefore, being able to interact with the host machine's Docker daemon from within the Jenkins container is fundamental. **Be very careful though: allowing containers to interact with the host machine's Docker daemon can compromise the security of the host machine. Make sure you trust the users who have access to the container as well as the base images being used. Only proceed with this technique if you feel comfortable. At the bottom of the page I have a few references to help elucidate this: [[5]](https://www.ctl.io/developers/blog/post/tutorial-understanding-the-security-risks-of-running-docker-containers), [[6]](https://stackoverflow.com/questions/40844197/what-is-the-docker-security-risk-of-var-run-docker-sock), [[7]](https://medium.com/cdex/steps-to-get-your-docker-host-compromised-e739a6967e47)**.

Because we don't need any build context (the set of files located in the specified path or url) for this image, we can run the following command to create the image:

```bash
docker build -t jenkins-docker-image - < Dockerfile
```

![step_1_build_image_from_dockerfile](/docs/images/step_1_build_image_from_dockerfile.PNG "Build image from Dockerfile")

This new image will be called ```jenkins-docker-image```. At the end of this build process we'll have two images, as shown below:

<a name="step_1_after_image_is_built"><p align="center"><img src="/docs/images/step_1_after_image_is_built.PNG" alt="Build image from Dockerfile" width="843" height="84"/></p></a>

## Create a Container from the Image <a name="create_a_container_from_the_image"></a>

Finally we create the container by running the following command:

```bash
docker run --name jenkins-docker-container -d -v /var/run/docker.sock:/var/run/docker.sock -v jenkins_home:/var/jenkins_home -p 8080:8080 -p 50000:50000 jenkins-docker-image
```

In the above command, we named the container ```jenkins-docker-container```. We are also binding two volumes: one for the Docker Unix socket, which will allow the container to manipulate the host’s Docker daemon, and another for the workspace ```/var/jenkins_home```, which stores Jenkins server data. This is useful because now the server data will remain within the Docker volume even after the container is stopped or even deleted.

Now let's talk about the ports used. As discussed in the [jenkinsci/docker documentation](https://github.com/jenkinsci/docker): "you can run builds on the master out of the box. But if you want to attach build slave servers through JNLP (Java Web Start): make sure you map the port: -p 50000:50000 - which will be used when you connect a slave agent". This port mapping is included here but will not be used in this tutorial. The other port is the Jenkins default port, 8080.

Lastly, we are running this container in detached mode, which means that this Docker container will run in the background, allowing you to execute other commands in the terminal. More info [here](https://stackoverflow.com/questions/34029680/docker-detached-mode).

In general, the ```run``` command we used is:

```bash
docker run --name <name_of_the_container> -d -v <volume_name_or_path>:<working_directory> -p <host_port>:<container_port> <docker_image_name>
```

Once the container is created, some of its information can be seen by running ```docker ps```, or by running

```bash
docker ps --format '\n\tContainer ID:\t{{.ID}}\n\tName:\t\t{{.Names}}\n\tStatus:\t\t{{.Status}}\n\tImage:\t\t{{.Image}}\n\tPorts:\t\t{{.Ports}}\n'
```

to get a cleaner version of the information about the container. It will look similar to this:

<a name="step_1_docker_ps_format"><p align="center"><img src="/docs/images/step_1_docker_ps_format.PNG" alt="Print container information" width="880" height="156"/></p></a>

## Connect to the Container's Terminal

If you are interested in connecting to the terminal of the running container, use:

```bash
docker exec -it jenkins-docker-container bash
```

In our example, we can check that indeed we are using the Docker from the host machine by running ```docker --version``` from within the container:

<a name="step_1_connect_to_container_terminal"><p align="center"><img src="/docs/images/step_1_connect_to_container_terminal.PNG" alt="Running Container's Console" width="680" height="75"/></p></a>

In general, you can run ```docker exec -it -u <user> <container_name_or_id> bash``` to specify any particular user (e.g. *root*). This can be very useful if for some reason you need to install something within the container, or check if a file or path is present in the container.
<br />  
<br />  
[Back to Overview](/README.md) or [Go to Next Step](/docs/step_2.md)

# References <a name="references"></a>
1) [Dockerfile reference](https://docs.docker.com/engine/reference/builder/)
2) [Jenkins base image](https://hub.docker.com/r/jenkins/jenkins)
3) [Docker in detached mode - Stackoverflow](https://stackoverflow.com/questions/34029680/docker-detached-mode)
4) [jenkinsci/docker](https://github.com/jenkinsci/docker)
5) [Understanding the Security Risks of Running Docker Containers](https://www.ctl.io/developers/blog/post/tutorial-understanding-the-security-risks-of-running-docker-containers)
6) [What is the Docker security risk of /var/run/docker.sock? - Stackoverflow](https://stackoverflow.com/questions/40844197/what-is-the-docker-security-risk-of-var-run-docker-sock)
7) [Steps to get your Docker host compromised](https://medium.com/cdex/steps-to-get-your-docker-host-compromised-e739a6967e47)
