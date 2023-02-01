# xAgent Dockerfile
Docker is a great way to securely run, well, anything. The trick is to properly craft a Dockerfile to tell Docker what to run. This repo details how to run the [xMatters xAgent](https://help.xmatters.com/ondemand/xmodwelcome/xmattersagent/xmatters-agent-topic.htm) on Docker.

<kbd>
  <img src="https://github.com/xmatters/xMatters-Labs/raw/master/media/disclaimer.png">
</kbd>

# Pre-Requisites
* [Docker](https://www.docker.com/)
* xMatters account - If you don't have one, [get one free](https://www.xmatters.com)!

# Files
* Dockerfile - The Dockerfile for telling Docker how to run the xMatters Agent

# How it works
Save the [Dockerfile](Dockerfile), [docker_entrypoint.sh](docker_entrypoint.sh), and [xmatters.com.repo](xmatters.com.repo) to the machine running docker, run the docker command and enjoy!

# Installation

First, login to your xMatters instance and navigate to **Workflows » Agents**. On the **Available** tab, you will see the install script. In this case it doesn't matter which OS is chosen because all we need are the API credentials. So copy `XMATTERS_HOSTNAME`, `XMATTERS_KEY` and `API_KEY` values and keep them handy.

# Building

Clone the repository to some place where you want to build the agent container.

```sh
$ git clone https://github.com/xmatters/xm-labs-xAgent-Dockerfile.git`
```

To build the docker image, run the build command from the same directory you save the Dockerfile
```sh
$ docker build -t xmatters-xa:latest .
```

# Running
The following ENV variables are required when running the container:
* `WEBSOCKET_HOST` or `XMATTERS_HOSTNAME` should point to your xMatters hostname. This should be something like `acme.xmatters.com`. Note: Do not include the `https://` portion.
* `WEBSOCKET_SECRET` or `XMATTERS_KEY` from the install script above.
* `OWNER_API_KEY` or `API_KEY` in the install script above.
* `FRIENDLY_NAME` is the agent name/description of your choosing that will be appended to `/default-`
in your XA's name in xMatters' UI.

## Example:

```bash
docker run --name xa-agent-name -d \
   -e WEBSOCKET_HOST=acme.xmatters.com \
   -e WEBSOCKET_SECRET=xxx \
   -e OWNER_API_KEY=yyy \
   -e FRIENDLY_NAME=zzz \
   xmatters-xa:latest
```
or 
```bash
docker run --name xa-agent-name -d \
   -e XMATTERS_HOSTNAME=acme.xmatters.com \
   -e XMATTERS_KEY=xxx \
   -e API_KEY=yyy \
   -e FRIENDLY_NAME=zzz \
   xmatters-xa:latest
```

If needed you can also pass any of the following proxy settings or any other env vars that the xmatters agent supports to the container:
* `XA_PROXY_AUTO`
* `XA_PROXY_PAC`
* `XA_PROXY_IP`
* `XA_PROXY_PORT`
* `XA_PROXY_USER`
* `XA_PROXY_PASS`
* `XA_PROXY_DOMAIN`
* `XA_PROXY_BYPASS`

Optionally, include `-p 8081` to expose an inbound HTTP listener in the xAgent to the system. This allows local triggering of HTTP triggers in xMatters.

This will create an xAgent in xMatters called:
> yourInstance-xmatters-com/default-zzz

#### Starting and Stopping

##### Stop the xAgent

    docker stop xa-agent-name

##### Start the xAgent

    docker start xa-agent-name


# Testing
After the `docker run` command chugs away for a moment, head over to the **Installed** tab of the Agents section and there will be a new agent!

<kbd>
	<img src="/media/agent-connected.png" width="600">
</kbd>


# Troubleshooting

The output of the `docker run` command will have any details of connection failures. Pay special attention to errors around the websocket connection. 
