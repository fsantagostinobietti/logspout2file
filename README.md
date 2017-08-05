# logspout2file
Save streaming logs from logspout to file.

It can be useful if you want to use it in conjunction with Splunk for application metrics.

WARNING: this is a quick&dirty implementation. Better solution requires coding a 3rd party module for logspout that saves logs to file system.

## features
 - it uses a log rotation strategy to save logs: file is renamed when it reaches a custom defined size
 - provided as a small deocker container
 
## build docker image
```
$ docker build -t logspout2file:latest .
```

## usage example
```
# a 'logspout' instance must be running
$ docker run -d --name="logspout" --volume=/var/run/docker.sock:/var/run/docker.sock gliderlabs/logspout

# 'logspout2file' instance depends on 'logspout' via --link
$ docker run -d --name="logspout2file" --link logspout -e LHOST="logspout" -v $(pwd)/tmp:/outdir  logspout2file:latest

# start applications you want to collect logs
$ docker run ...
```

If your applications produce log lines you'll see them in mounted volume (in this example '$(pwd)/tmp').
```
$ la -1 $(pwd)/tmp
logfile
logfile.2017-08-05_15:04:09
```

## customization
You can customize some features using env variables:

env name |  description   | default value
---------|----------------|--------------
LHOST | logspout server host address | 
LPORT | logspout server host port    |  80
FFILENAME | file name for output log  | logfile
FFILESIZE | file size in bytes | 10485760 == 10Mbyte
