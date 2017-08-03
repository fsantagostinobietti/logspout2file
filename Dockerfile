FROM alpine:3.3

ADD myRotateLog.sh /usr/local/bin/myRotateLog.sh
RUN chmod a+x /usr/local/bin/myRotateLog.sh

RUN mkdir /outdir
VOLUME /outdir

RUN apk update && \
    apk add curl && \
    apk add expect
    


ENTRYPOINT exec unbuffer curl --silent --no-buffer http://${LHOST}:${LPORT:-8000}/logs | myRotateLog.sh /outdir/logfile 102400

