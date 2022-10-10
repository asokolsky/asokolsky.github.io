# Jenkins on MacOS HOWTO

## Installation

```sh
$ brew install jenkins-lts
$ brew services start jenkins-lts
```

## Configuration

Point your browser to `http://localhost:8080` and login using password from
`~/.jenkins/secrets/initialAdminPassword`
Create admin username/password.

Proceed with installation of the suggested plugins: iInstall s3 publisher
plugin.

Next:

* Create a new pipeline;
* pick sample Hello World script;
* Build it;
* Verify success;
* examine logs.

You will get a security warning:
"Building on the built-in node can be a security issue..."

## Configure Jenkins Agent with Docker

I generally followed
[these instructions](https://www.jenkins.io/doc/book/using/using-agents/)
though they prooved to be insufficient:

1. Create jenkins_agent_key pair;
2. Launch the agent agent1 - note use of host port 2222 being mapped to
container's port 22:

```sh
docker run -d --rm --name=agent1 -p 2222:22 \
    -e "JENKINS_AGENT_SSH_PUBKEY=ssh-rsa AA..."\
    jenkins/ssh-agent:alpine
VARS1="HOME=|USER=|MAIL=|LC_ALL=|LS_COLORS=|LANG="
VARS2="HOSTNAME=|PWD=|TERM=|SHLVL=|LANGUAGE=|_="
VARS="${VARS1}|${VARS2}"
docker exec agent1 sh -c "env | egrep -v '^(${VARS})' >> /etc/environment"
```

Use MacOS Docker desktop:

* check log - it should end with a message that sshd is listening on port 22
* inspect environment variables JAVA_HOME, JAVA_VERSION, PATH -
you will need the values of these in the next step.

3. Add agent1 to Jenkins as a permanent agent.

I set:

* 'Remote root directory' to  `/home/jenkins`
* 'Launch method' picked Launch agents via SSH and then
* in Advanced section set port to 2222, add environment variables for PATH,
JAVA_HOME, JAVA_VERSION with values from previous step.

Launch the agent1, confirm success.

A security message advises to set the number of executors on the Built-in
node to 0.  Do it.
