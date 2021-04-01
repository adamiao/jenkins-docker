[Go to Previous Step](/docs/step_3.md)
<br />  
<br />  
Let's create a *webhook* by going to the repository's *Settings*, then clicking on *Webhooks* on the left pane, then clicking on *Add webhook*:

<a name="step_4_add_webhook"><p align="center"><img src="/docs/images/step_4_add_webhook.PNG" alt="Add Webhook" width="100%"/></p></a>

The ```Payload URL``` is the address in which the Docker host is running with its Jenkins container. This address must be such that GitHub is able to connect to it. Make sure you have ```/github-webhook/``` at the end of the URL. The ```Content type``` must be *application/json*. Finally we'll keep the events to just be the ```push``` event. Click on *Add webhook*:
<a name="step_4_configure_webhook"><p align="center"><img src="/docs/images/step_4_configure_webhook.PNG" alt="Configure Webhook" width="75%"/></p></a>

Click on the webhook just created to see if everything is as expected. Once you come back to the *Webhooks* page you should see a green check next to the webhook.
<a name="step_4_webhook_connects"><p align="center"><img src="/docs/images/step_4_webhook_connects.PNG" alt="Webhook Connects" width="100%"/></p></a>

Let's test this setup! Make a push to change the repository. Once the push is received by GitHub, a webhook is sent to Jenkins, triggering the pipeline. You should see a pending process within Jenkins:
<a name="step_4_webhook_successful"><p align="center"><img src="/docs/images/step_4_webhook_successful.PNG" alt="Webhook Connects" width="75%"/></p></a>

If you're interested in looking at the outputs of this run live, you may click on *Console Output*:
<a name="step_4_console_output"><p align="center"><img src="/docs/images/step_4_console_output.PNG" alt="Configure Webhook" width="25%"/></p></a>

Notice that the results of the tests are seen in the output:
<a name="step_4_console_logs"><p align="center"><img src="/docs/images/step_4_console_logs.PNG" alt="Add Webhook" width="75%"/></p></a>

This concludes this tutorial.
<br />  
<br />  
[Go to Previous Step](/docs/step_3.md)
