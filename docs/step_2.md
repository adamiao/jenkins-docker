[Go to Previous Step](/docs/step_1.md) or [Go to Next Step](/docs/step_3.md)
<br />  
<br />  
Let's now unlock the Jenkins interface so we can create the pipeline for this project. First make sure that the Jenkins container is running by using ```docker ps```. If it's not, then go to the previous step and make sure you get the container created and running.

Now we want to connect to the address of this Jenkins container. If you are working on the same machine in which Docker is installed, then you want to go to ```http://localhost:8080/```. In this tutorial Docker is installed at the LAN address *192.168.2.6*. Therefore ```http://192.168.2.6:8080/``` is used. **Remark: when setting up the webhook from GitHub, Docker will have to be installed at an address GitHub can find.**

If this is the first time unlocking Jenkins you will get the following screen:

<a name="step_2_setup_unlock_jenkins"><p align="center"><img src="/docs/images/step_2_setup_unlock_jenkins.PNG" alt="Unlock Jenkins" width="566" height="268"/></p></a>

# Getting the Secret <a name="getting_the_secret"></a>

There are multiple ways of getting this secret. One way of doing it is to see the logs of a running container:

```bash
docker logs <container_id_or_name>
```

<a name="step_2_jenkins_secret"><p align="center"><img src="/docs/images/step_2_jenkins_secret.PNG" alt="Jenkins secret" width="510" height="138"/></p></a>

The secret may not show if you run this command right after starting the container. Just wait for a few seconds and run it again.

Another way you can retrieve the secret is by looking at the file ```/var/jenkins_home/secrets/initialAdminPassword```. As you may recall, while creating the container, a volume bind was made. This means that files are being shared between the host machine and the container. We can find the location of the data in the host machine by inspecting the volume: ```docker volume inspect <volume_name>```:

<a name="step_2_docker_volume_inspect"><p align="center"><img src="/docs/images/step_2_docker_volume_inspect.PNG" alt="Inspecting Docker Volume" width="402" height="123"/></p></a>

The ```Mountpoint``` is the path in the host machine that contains the data of the container's workspace. Run the following command to see the secret:

```bash
cat /var/lib/docker/volumes/jenkins_home/_data/secrets/initialAdminPassword
```

Copy the secret value and unlock Jenkins.

# Jenkins Setup <a name="jenkins_server"></a>

Once you've unlocked Jenkins, you will get to the page where you need to choose the plugins you want installed:

<a name="step_2_install_plugins_jenkins"><p align="center"><img src="/docs/images/step_2_install_plugins_jenkins.PNG" alt="Jenkins Plugins" width="611" height="366"/></p></a>

To follow this tutorial my suggestion is to choose the default plugin choices, but you can pick and choose according to your project needs:

<a name="step_2_plugin_install"><p align="center"><img src="/docs/images/step_2_plugin_install.PNG" alt="Plugins Installation" width="628" height="310"/></p></a>

Once the install is done you'll be taken to the *Create First Admin* page. For now we'll just skip and continue as *admin*:

<a name="step_2_create_first_admin"><p align="center"><img src="/docs/images/step_2_create_first_admin.PNG" alt="Create First Admin" width="552" height="372"/></p></a>

Finally, we'll click on *Save and Finish*:

<a name="step_2_instance_config"><p align="center"><img src="/docs/images/step_2_instance_config.PNG" alt="Instance Configuration" width="547" height="364"/></p></a>

This finishes the setup! If you're interested in changing the password of this account, you can go to the top right of the page and click on the *Admin* tab and then *Configure*:

<a name="step_2_change_password"><p align="center"><img src="/docs/images/step_2_change_password.PNG" alt="Change Password" width="161" height="147"/></p></a>

If you then scroll down you will see where you can change the password.
<br />  
<br />  
[Go to Previous Step](/docs/step_1.md) or [Go to Next Step](/docs/step_3.md)
