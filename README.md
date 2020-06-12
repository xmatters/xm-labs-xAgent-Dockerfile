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

First, login to xMatters and navigate to the **Developer** tab and click the **Agents**. On the **Available** tab, you will see the install script for the selected OS. In this case it doesn't matter because all we need are the API keys. So copy the `XMATTERS_KEY` and `API_KEY` values and keep them handy. These are the values pointed to by the green arrows here and hidden behind the white wall:

<kbd>
   <img src="/media/install-script.png" width="300">
</kbd>

Then, save the [Dockerfile](Dockerfile) to some place where you want to run the agent.

# Running

To build the docker image, run the build command from the same directory you save the Dockerfile
```
docker build -t xa:latest .
```

Then, run the following command, swapping out these values:
* `WEBSOCKET_HOST` should point to your xMatters host url. This should be something like `https://acme.xmatters.com`
* `WEBSOCKET_SECRET` is `XMATTERS_KEY` from the install script above
* `OWNER_API_KEY` is the `API_KEY` in the install script above
* `FRIENDLY_NAME` is a string of your choosing that will be appended to `/default-`
in your XA's name in xMatters' UI.


```bash
docker run --name xa-whatever -d \
   -e WEBSOCKET_HOST=https://acme.xmatters.com \
   -e WEBSOCKET_SECRET=xxx \
   -e OWNER_API_KEY=yyy \
   -e FRIENDLY_NAME=zzz \
   xa:latest
```

Optionally, include `-p 8081` to expose an inbound HTTP listener in the xAgent to the system. This allows local triggering of HTTP triggers in xMatters.

This will create an xAgent in xMatters called:
> yourInstance-xmatters-com/default-zzz

#### Starting and Stopping

##### Stop the xAgent

    docker stop xa-whatever

##### Start the xAgent

    docker start xa-whatever


# Testing
After the `docker run` command chugs away for a moment, head over to the **Installed** tab of the Agents section and there will be a new agent!

<kbd>
	<img src="/media/agent-connected.png" width="600">
</kbd>


# Troubleshooting

The output of the `docker run` command will have any details of connection failures. Pay special attention to errors around the websocket connection. 
