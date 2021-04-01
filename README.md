# Jenkins-Docker Tutorial
1. [Overview](#overview)
2. [Tutorial](#tutorial)
3. [References](#references)

# Overview <a name="overview"></a>
Let's start with a high-level overview of what we're trying to accomplish. Our goal is to setup a continuous integration (CI) pipeline that tests a project any time a contributor makes changes to it. By project it is meant the collection of files (code, configuration files, data files, test files, etc.) necessary to build the application.

Our testing pipeline is made up of two parts: the Jenkins server and the GitHub repository. The Jenkins server is the environment where the project gets tested. The GitHub repository is where the source code is kept and changed by all contributors. Once any of these changes comes in, the repository will communicate with the Jenkins server by means of a *webhook*, and start the build-test-deploy process of the project. With the purpose of learning some containerization fundamentals, this Jenkins server will be running out of a Docker container.

Running such pipelines from containers can be powerful. As long as you have all of the configuration files (Dockerfile and Jenkinsfile for now) in hand, creating a Jenkins CI pipeline able to test your project becomes a much simpler task. In fact, you can version control this "recipe" alongside the project's repository. Another great reason to have this containarized pipeline is that it can run on any computer that is able to interact with the container technology (in our case, Docker).

By the way, at the end of the page you'll find some interesting references I found on the web which were very useful for me to understand how this whole thing works.

# Tutorial <a name="tutorial"></a>

Before we begin, let me make a few remarks. It is not the purpose of this tutorial to explain how Docker, Jenkins, or Python works. Although I'll go over some Docker commands, I'm not going to discuss anything outside what is needed for this project. The same applies for Jenkins. This tutorial is about how to set up this testing infrastructure using these tools.

Let's now go over what we'll be using to accomplish this task. Because the focus of the project is on the testing infrastructure, the actual project we'll be testing is quite simple. As is tradition, we'll be testing a calculator that does addition and multiplication operations using Python.

To complete this project, we must:

1) [Set up the host machine to run the Jenkins server](/docs/step_1.md).

2) [Unlock the Jenkins interface](/docs/step_2.md).

3) [Create a multibranch pipeline](/docs/step_3.md).

4) [Integrate Jenkins with GitHub](docs/step_4.md) so the pipeline can be tested automatically.

# References <a name="references"></a>
1) [Build your first Automated Test 
with pytest, Jenkins and Docker](https://medium.com/swlh/build-your-first-automated-test-integration-with-pytest-jenkins-and-docker-ec738ec43955)

2) [Build a Docker image using a Jenkins pipeline](https://www.edureka.co/community/55640/jenkins-docker-docker-image-jenkins-pipeline-docker-registry)
3) [Using Docker-in-Docker for your CI or testing environment? Think twice.](https://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci/)
