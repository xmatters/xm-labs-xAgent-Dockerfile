# xAgent Containerfile
Docker/Podman is a great way to securely run, well, anything. The trick is to properly craft a Dockerfile/Containerfile to tell Docker/Podman what to run. This repo details how to run the [xMatters xAgent](https://help.xmatters.com/ondemand/xmodwelcome/xmattersagent/xmatters-agent-topic.htm) on Docker or Podman.

<kbd>
  <img src="https://github.com/xmatters/xMatters-Labs/raw/master/media/disclaimer.png">
</kbd>

# Pre-Requisites
* [Docker](https://www.docker.com/) or [Podman](https://podman.io/)
* xMatters account - If you don't have one, [get one free](https://www.xmatters.com)!

# How it works
Save the [Containerfile](Containerfile) ([Dockerfile](Dockerfile)), [entrypoint.sh](entrypoint.sh), and [xmatters.com.repo](xmatters.com.repo) to the machine running docker/podman, run the docker/podman command and enjoy!

# Installation

First, login to your xMatters instance and navigate to **Workflows » Agents**. On the **Available** tab, you will see the install script. In this case it doesn't matter which OS is chosen because all we need are the API credentials. So copy `XMATTERS_HOSTNAME`, `XMATTERS_KEY` and `API_KEY` values and keep them handy.

# Building

Clone the repository to some place where you want to build the agent container.

```sh
$ git clone https://github.com/xmatters/xm-labs-xAgent-Dockerfile.git`
```

To build the container image, run the build command from the same directory you save the Containerfile (Dockerfile).
```sh
# Docker
$ docker build -t xmatters-xa:latest .

# or Podman
$ podman build -t xmatters-xa:latest .
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
# Docker
docker run --name xa-agent-name -d \
   -e XMATTERS_HOSTNAME=acme.xmatters.com \
   -e XMATTERS_KEY=xxx \
   -e API_KEY=yyy \
   -e FRIENDLY_NAME=zzz \
   xmatters-xa:latest

# Podman
podman run --name xa-agent-name -d \
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
    
    podman stop xa-agent-name

##### Start the xAgent

    docker start xa-agent-name
    
    podman start xa-agent-name


# Testing
After the `docker run` or `podman run` command chugs away for a moment, head over to the **Installed** tab of the Agents section and there will be a new agent!

<kbd>
	<img src="/media/agent-connected.png" width="600">
</kbd>


# Troubleshooting

The output of the `docker run` or `podman run` command will have any details of connection failures. Pay special attention to errors around the websocket connection. 
