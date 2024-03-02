# A Simple Local RAG ChatBot

This repo represents my test implementation of this [very helpful example](https://datasciencenerd.us/build-a-chatbot-using-local-llm-6b8dbb0ca514) for building a local RAG-enabled chatbot. I expect that the logic and such contained herein will change frequently as I learn and understand more. However, the main branch should always be in a usable state relative to whatever adjustments I have decided to implement.

## Initial Implementation

My initial code implementation was to follow the blog and use the code provided in the given state. However, instead of installing everything locally on my machine or directly on an instance in the cloud, I decided to dockerize the components in order to make it more universal and portable. Those basic changes are:

* Add a Dockerfile for the Ollama server

    **NOTE:** I am building a base container and installing Ollama, but this is not necessary. Ollama offers an official [server docker image](https://hub.docker.com/r/ollama/ollama) that you should probably use instead.
* Add a Dockerfile for the StreamLit UI
* Add a docker-compose file to orchestrate the two
* Update the model connection string in [rag.py](./rag.py) to look at the docker service hostname and port

## TODO
There are several initial improvements that I intend to make before making major changes to the logic:

- [ ] Create .env to hold environment configs, like server name and port
- [ ] Persist model data on local disk so data isn't lost on docker volume removal
- [ ] Switch server container to the official Ollama image instead of building our own
