FROM node

WORKDIR /usr/src/app

RUN git clone https://github.com/MarSouz/Sparrow.git

RUN cp -r Sparrow/Sparrow/* /usr/src/app/

EXPOSE 3333

WORKDIR /usr/src/app/Sparrow/Sparrow

RUN npm install

CMD ["npm", "start"]