# A Simple Local RAG ChatBot

This repo represents my test implementation of this [very helpful example](https://datasciencenerd.us/build-a-chatbot-using-local-llm-6b8dbb0ca514) for building a local RAG-enabled chatbot. I expect that the logic and such contained herein will change frequently as I learn and understand more. However, the main branch should always be in a usable state relative to whatever adjustments I have decided to implement.

## Initial Implementation

My initial code implementation was to follow the blog and use the code provided in the given state. However, instead of installing everything locally on my machine or directly on an instance in the cloud, I decided to dockerize the components in order to make it more universal and portable. Those basic changes are:

* Add a Dockerfile for the Ollama server

    **NOTE:** I am building a base container and installing Ollama, but this is not necessary. Ollama offers an official [server docker image](https://hub.docker.com/r/ollama/ollama) that you should probably use instead.
* Add a Dockerfile for the StreamLit UI
* Add a docker-compose file to orchestrate the two
* Update the model connection string in [rag.py](./src/rag.py) to look at the docker service hostname and port

## Running

### Setup

To start the containers in a daemon (omit the `-d` for non-daemon):

```text
docker compose up --build -d
```

**Note**: The first time you run these containers (or if you delete your docker volumes and I haven't implemented persistent storage yet), you'll need to run the following command to pull the model down locally.

```text
docker exec -it testrag-server-1 ollama pull neural-chat
```

**Another Note**: This is using the [neural-chat](https://ollama.com/library/neural-chat) model, but you can replace this with any model that [Ollama supports](https://ollama.com/library). Just remember you'll have to replace this in the model definition in [rag.py](./src/rag.py) before you pull a new one. Be sure, also, when choosing a model, you pay attention to the RAM requirements and such. For example, [Llama2](https://ollama.com/library/llama2) can be hefty.

Then:

* Browse to <http://localhost:8080> and you should see the StreamLit interface
* Upload the included [CSV](./data-science-resumes.csv)

  _Note: This is a much smaller version of the [original](https://github.com/ecdedios/resume-chatbot-local-llm/blob/main/data/data-science-resumes.csv) because I was havig timeout issues. I'm not sure if this is because my machine is so underpowered or because of an issue in the code. Use whichever version you like._
* Ask it some question

If you're running in a daemonized way, you can see and tail the output of your containers by running:

```text
docker compose logs -f
```

### Teardown

---

**Important**: If you have other important containers running, be sure you know what you are doing before you run any of these commands. These _shouldn't_ interfere with anything else, but I make no claim that they will not. Caveat emptor and tempus fugit and cave canum and all that. Whatever.  Just be careful.

---

In order to remove what you've set up, run the following:

```text
docker compose stop
docker compose down
```

This will stop and remove the containers, but leave the volumes in place. You could only run the `stop` command if you don't need to remove the containers, but that's up to you. In order to remove the volumes, too, you can do:

```text
docker compose down --volumes
```

**Remember**: I know I just said this, but that command will remove volumes, and if the data isn't persisted to disk, you'll need to re-pull any models you are using.

If you want to obliterate everything (containers, volumes, networks, images), do:

```text
docker compose down --rmi all --volumes
```

## TODO

There are several initial improvements that I intend to make before making major changes to the logic:

- [ ] Create .env to hold environment configs, like server name and port
- [ ] Parameterize the model the app uses
- [ ] Ensure model data is downloaded on project start
- [ ] Persist model data on local disk so data isn't lost on docker volume removal
- [ ] Switch server container to the official Ollama image instead of building our own
