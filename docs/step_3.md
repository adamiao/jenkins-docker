[Go to Previous Step](/docs/step_2.md) or [Go to Next Step](/docs/step_4.md)
<br />  
<br />  
Now that we're done with the initial setup, let's create a multibranch pipeline. Click on *New Item*:

<a name="step_3_new_item"><p align="center"><img src="/docs/images/step_3_new_item.PNG" alt="Create new item" width="30%"/></p></a>

Add a name to this pipeline, select ```Multibranch Pipeline```, then click *OK*:

<a name="step_3_multibranch_pipeline"><p align="center"><img src="/docs/images/step_3_multibranch_pipeline.PNG" alt="Multibranch Pipeline" width="70%"/></p></a>

Now it's time to set up the SSH credentials so Jenkins can pull the repository from GitHub.

# Setup ```SSH``` Credentials <a name="add_ssh_credentials"></a>

Jenkins must have credentials before it's able to pull data from private GitHub repositories. For public repositories, all you need is the HTTPS clone path. For example:

```bash
https://github.com/adamiao/jenkins-docker.git
```

Since you may be using private repositories, we'll set up SSH credentials in this tutorial. Once the pair of SSH keys is shared by the container and the repository, Jenkins will have permission to pull the project and run the build/test/deploy processes.

The first thing we need to do is create a *.ssh* folder anywhere on the host machine. Next we'll add a file within this folder, called ```config``` (no extension), which has the information below:

```bash
Host github.com
 Hostname github.com
 User git
 IdentityFile /var/jenkins_home/.ssh/id_rsa
 IdentitiesOnly yes
```

The ```config``` file contains configuration parameters for the SSH connection such as the location of the SSH keys. This file can have multiple blocks in them, one for each *Host*. But here we'll only be using one. Notice that the *IdentityFile* points to a location that doesn't exist in the host machine. However, this will exist in the container once we move *.ssh* there.

Next we create the SSH keys by running the following command:

```bash
ssh-keygen -t rsa -b 4096
```

When setting up the key, make sure you save it within the *.ssh* folder just created. This is very important! After all is said and done, the *.ssh* folder will contain the following files:

<a name="step_3_ls_ssh"><p align="center"><img src="/docs/images/step_3_ls_ssh.PNG" alt=".ssh folder contents" width="316" height="46"/></p></a>

Next we must copy this folder and all of its contents to the container. We do that by copying it to the volume location in the host machine. Remember that you can run ```docker volume inspect <volume_name>``` to find the location of the volume within the host machine. The copy command will look something like this:

```bash
cp -r .ssh /var/lib/docker/volumes/jenkins_home/_data
```

For the last step, we have to copy the public key (```id_rsa.pub```) and place it in GitHub. This will be the key that will check the credentials used by Jenkins. To do that we'll go to the *Settings* tab of the repository, then on the left pane go to *Deploy keys*, and finally click on *Add deploy key*:

![step_3_deploy_key_0](/docs/images/step_3_deploy_key_0.PNG "Deploy keys")

You may or may not want to give write access to the key. This is up to you and your use case. For this tutorial the key will not have write access. Once this process is done you will see the following:

![step_3_deploy_key_1](/docs/images/step_3_deploy_key_1.PNG "Deploy keys")

# Multibranch Pipeline <a name="multibranch_pipeline"></a>

Going back to the pipeline within Jenkins we see the following screen:
<a name="step_3_multibranch_interface"><p align="center"><img src="/docs/images/step_3_multibranch_interface.PNG" alt="Pipeline Interface" width="100%"/></p></a>

Under the section ```Branch Sources```, add the source ```Git```:
<a name="step_3_branch_source"><p align="center"><img src="/docs/images/step_3_branch_source.PNG" alt="Branch Source - Git" width="25%"/></p></a>

Next, get the SSH clone path on your GitHub repository:
<a name="step_3_github_ssh_path"><p align="center"><img src="/docs/images/step_3_github_ssh_path.PNG" alt="GitHub SSH Path" width="75%"/></p></a>

Use this path for the *Project Repository* value. Next let's add a credential to this pipeline:
<a name="step_3_credential_pipeline_0"><p align="center"><img src="/docs/images/step_3_credential_pipeline_0.PNG" alt="Create new item" width="25%"/></p></a>

Make sure that under ```Kind``` you have *SSH Username with private key* selected. Other than that, you only really need to add a *Username* to this credential since the SSH keys are in a default location within the container for GitHub to find.
<a name="step_3_credential_pipeline_1"><p align="center"><img src="/docs/images/step_3_credential_pipeline_1.PNG" alt="Create new item" width="75%"/></p></a>

Finally, make sure that the credential just created is selected:
<a name="step_3_credential_pipeline_2"><p align="center"><img src="/docs/images/step_3_credential_pipeline_2.PNG" alt="Create new item" width="25%"/></p></a>

Once this last step is done, click the **Save** button. Once saved, the pipeline should start a first automatic run. The *Scan Multibranch Pipeline Log* page looks like below:

<a name="step_3_scan_pipeline"><p align="center"><img src="/docs/images/step_3_scan_pipeline.PNG" alt="Scan Pipeline" width="75%"/></p></a>

If it does not start, press *Scan Multibranch Pipeline Now*, on the left pane.

# Jenkinsfile <a name="jenkinsfile"></a>

The pipeline that just ran was orchestrated by [*Jenkinsfile*](https://github.com/adamiao/jenkins-docker/blob/main/Jenkinsfile). This is a text file that defines the CI/CD pipeline logic for a project with steps to build/test/deploy etc. [[2]](https://www.jenkins.io/blog/2015/12/03/pipeline-as-code-with-multibranch-workflows-in-jenkins/)

Because the *Jenkinsfile* can group commands together in *stages*, you are able to see the logs for each one of them. To see them, first go to the pipeline of interest and then click on the branch you're testing on. Here we are testing the ```main``` branch:

<a name="step_3_go_to_main_branch"><p align="center"><img src="/docs/images/step_3_go_to_main_branch.PNG" alt="Go to Main Branch" width="75%"/></p></a>

Notice how you are able to see the results of each step:

<a name="step_3_pipeline_ran"><p align="center"><img src="/docs/images/step_3_pipeline_ran.PNG" alt="Run Results" width="75%"/></p></a>

Next we'll set up a way for Jenkins to trigger the pipeline once changes are made in the GitHub repository.
<br />  
<br />  
[Go to Previous Step](/docs/step_2.md) or [Go to Next Step](/docs/step_4.md)


# References <a name="references"></a>
1) [Pipeline: Multibranch](https://www.jenkins.io/doc/pipeline/steps/workflow-multibranch/#pipeline-multibranch)
2) [Pipeline-as-code with Multibranch Workflows in Jenkins](https://www.jenkins.io/blog/2015/12/03/pipeline-as-code-with-multibranch-workflows-in-jenkins/)
