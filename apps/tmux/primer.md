# tmux primer

Why Use Tmux?

* Persistence: If your SSH connection drops, your programs keep running.
* Workflow Efficiency: Split screens for viewing logs, editing code, and running tests simultaneously.
* Customization: Use a .tmux.conf file to change keybindings, add plugins (like tpm), and customize the status bar.
* Copy/Paste: Use Prefix + [ to enter copy mode, allowing you to scroll and copy text with vi-like motions.

Here is a quick way to get you started.

## Establish the session on a remote server

In your terminal connect to the remote server:

```sh
ssh alex@remote-server
```

Start tmux:

```
alex@remote-server > tmux
# you've got a new prompt
# start a new lengthy process, e.g. this one-liner
alex@remote-server > START=$SECONDS; while true; do sleep 1; echo "Elapsed: $((SECONDS - START)) seconds"; done
```

By now a lengthy process started on the remote server.

## Detach from the session on a remote server

You can now detach from the session: `Ctrl-b  d`.

Or you can just kill your terminal.

## Attach to the previously started session

In your terminal connect to the remote server:

```sh
ssh alex@remote-server
```

List the existing sessions:

```sh
tmux ls
```

Attach this terminal to the last session:

```sh
tmux at
```

Observe the time being calculated since the process was started.

If more than one session is available, attach to the one of your choice:

```sh
`tmux at -t _ses_`
```
