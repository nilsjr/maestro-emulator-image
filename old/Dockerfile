FROM nilsjrfn/android-emulator-30:latest
LABEL maintainer="Nils Druyen <nils.druyen@fressnapf.com>"

WORKDIR $HOME

COPY create_avd.sh $HOME/
COPY launch_emulator.sh $HOME/

#ADD create_avd.sh /
#RUN chmod +x create_avd.sh
#RUN ./create_avd.sh

ENTRYPOINT ["tail", "-f", "/dev/null"]