# xAgent Dockerfile
Docker is a great way to securely run, well, anything. The trick is to properly craft a Dockerfile to tell Docker what to run. This repo details how to run the [xMatters xAgent](https://help.xmatters.com/ondemand/xmodwelcome/xmattersagent/xmatters-agent-topic.htm) on Docker.

<kbd>
  <img src="https://github.com/xmatters/xMatters-Labs/raw/master/media/disclaimer.png">
</kbd>

# Pre-Requisites
* [Docker](https://www.docker.com/)
* xMatters account - If you don't have one, [get one](https://www.xmatters.com)!

# Files
* Dockerfile - The Dockerfile for telling Docker how to run the xMatters Agent

# How it works
Save the [Dockerfile](Dockerfile) to the machine running docker, run the docker command and enjoy!

# Installation

First, login to xMatters and navigate to the Developer tab and click the Agents. On the Available tab, you will see the install script for the selected OS. In this case it doesn't matter because all we need are the API keys. So copy the `XMATTERS_KEY` and `API_KEY` values and keep them handy. These are the values pointed to by the green arrows here and hidden behind the white wall:

<kbd>
   <img src="/media/install-script.png">
</kbd>

Then, save the [Dockerfile](Dockerfile) to some place where you want to run the agent.

Finally, run the following command swapping out the following values:
* `WEBSOCKET_HOST`should point to your xMatters host url. This should be something like `https://acme.xmatters.com`
* `WEBSOCKET_SECRET` is `XMATTERS_KEY` from the install script
* `OWNER_API_KEY` is the `API_KEY` in the install script


# Testing


# Troubleshooting
