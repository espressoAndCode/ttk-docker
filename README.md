# Paraview + TTK Docker Image

### This repo was forked from [scivislab/ttk-docker](https://github.com/scivislab/ttk-docker)

I made minor changes to use this Docker image for Clemson CPSC8030 - Spring 2021. 

## Instructions - Docker ParaView + TTK Server

1. Install [Docker](https://www.docker.com/get-started) on your system.
1. From the command line, clone this repo to your machine.
    ```
    git clone https://github.com/espressoAndCode/ttk-docker.git
    ```
1. Navigate into the repo.
    ```
    cd ttk-docker
    ```
1. Create a directory for your data. You will use this eventually, but don't navigate into this directory at this time.
    ```
    mkdir data
    ```
1. Build the Docker instance. This will take a while.
    ```
    docker build .
    ```
1. When the build is complete, test start the container using:
    ```
    ./run-ttk
    ```
    The container process should run, and you will see something similar to:
    ```
    Waiting for client...
    Connection URL: cs://67db73f89258:11111
    Accepting connection(s): 67db73f89258:11111
    ```
    The ParaView + TTK Server is now running in the Docker container and awaiting a connection from a ParaView client.

## Instructions - ParaView Client

In order to connect to the Docker server, you must have a ParaView client on your machine. Fortunately you don't need to build this from source, you can just install one of the precompiled versions from the ParaView website.

1. From a browser, navigate to the [Paraview downloads page](https://www.paraview.org/download/). Go to the Version pulldown and choose `v5.6`. Download `ParaView-5.6.1 .zip` for your platform. You *must* use this specific version to work with the Docker image.

1. When the download is complete, extract the archive and move the folder wherever you want it. For convenience, you may want to locate the executable and create a shortcut, then move the shortcut to your desktop.

FYI, ParaView does not install as a typical application. Instead, it downloads a folder structure, and the executable is located in the `.bin` folder for a Windows machine.

## Configure the ParaView Client for Server Connection

1. Open ParaView by double-clicking the executable shortcut.

1. Click on `File > Connect`, and a dialog box will open.

1. Click `Add Server`

1. Add the following:

    - Name (Whatever you would like to name it)
    - Server Type:  `Client/Server`
    - Host:         `localhost`
    - Port:         `11111`

    Then click `Configure`. You only have to configure once, ParaView will retain this for future connections. If your Docker ParaView + TTK Server is still running you can now connect to it.

## Connect the ParaView Client to the Docker Server

1. In a terminal window, navigate to the `ttk-docker` folder.

1. Run the `Docker ParaView + TTK Server`:
    ```
    ./run-ttk
    ```
1. Open the ParaView client.

1. Click on `File > Connect`, and in the dialog box click `Connect`.

1. You should now see your connection in the `Pipeline Browser` window. Your Docker terminal should also say `Client connected`.

1. You can close the plugin manager dialog box if it opens automatically on connection.

## To access data files.

You can download data files and move them to the `~/ttk-docker/data/` directory as you normally would.

1. From the ParaView client interface, right-click on the Docker instance in the `Pipeline Browser` window and click `Open`.

1. The path should be `/home/paraview/`, or similar. Navigate up one level and into the directory of the Docker server. You should see the `data` folder that you created earlier. Navigate into that folder to load data items as needed.

## Disconnect and Shutdown

1. To disconnect the ParaView client, go to `File > Disconnect`. You can now close ParaView.

1. The terminal will show `Exiting...` when you disconnect from ParaView, and the container will shutdown automatically. You can now close the terminal window.

---
## README from original repo:

This docker image contains an installation of the [Topology Tool Kit (TTK)](http://topology-tool-kit.github.io) and [ParaView](http://www.paraview.org) server built from source. Specifically:

- ParaView server with offscreen rendering using either [OSMesa](http://www.mesa3d.org/osmesa.html) or [OSPRay](http://www.ospray.org).
- TTK for ParaView plugins are installed.

It is supposed to be used in conjunction with a local ParaView GUI.

## Simple usage

To run Kitware's binary distribution of ParaView with TTK's docker, simply run:

``` ./runParaViewTTKDocker.sh <Path to ParaView binary (version 5.6.1)> [<Standard ParaView arguments (state files, data, etc.)>]```

To run a python script which uses TTK, simply run:

``` ./runTTKPythonDocker.sh [<Standard pvpython arguments: Python script, data, etc. ABSOLUTE PATHS ONLY)>]```

## Advanced usage

```docker run -it --rm -p 11111:11111 -v "$HOME:/home/`whoami`/" --user $UID topologytoolkit/ttk:5.6.1-master```

will start `pvserver` version 5.6.1 with TTK (current master version) and listen on the default port 11111 for connections from a ParaView GUI. The directory `$(pwd)/data` will be mounted under `/home/paraview/data` in the container.

If the container is executed on a remote host, consider using the command
```
ssh -L 11111:localhost:11111 user@host docker run ...
```
which will set up the appropriate port forwarding as well. The GUI should then be able to connect to `localhost:11111`.

Notes:
- The versions of the ParaView GUI and `pvserver` have to match exactly.
- `pvserver` will currently exit after the GUI has disconnected, i.e. the container must be restarted.



## Custom Images

To re-build the image, simply clone this repository and run `docker build`. (This will use an existing docker image of ParaView and build TTK into it.)

The Dockerfile supports building a specific TTK version using the `ttk` build argument. This can be set to the designation of any branch or tag from TTK's GitHub [repository](https://github.com/topology-tool-kit/ttk), e.g. "`master`" or "`v0.9.7`".

For example,
```
docker build -t paraview-ttk:5.6.1-master --build-arg ttk=master .
```
will build an image for TTK's master branch on top of the latest ParaView release.

