# Container Sid

O Dockerfile foi escrito baseado no "Guia Rápido de Empacotamento de Software no Debian" de João Eriberto Mota Filho, disponível em debianet.com.br.

A inspiração para compartilhar esse Dockerfile veio de assistir a palestra:

- [Empacotamento Debian com Docker](https://www.youtube.com/watch?v=G3zdpXAlYq0) do @d4n1.

## Build da imagem

```bash
docker compose -f compose.yml up -d
```

Para entrar num container e ter acesso ao terminal:

```bash
docker exec -it insiraoiddocontainer /bin/bash
```

Dica: Rode `docker ps -a` para verificar o id do container.

## CURIOSIDADE: Criar container com uma Shell Function (usando Podman)

Adicione as linhas abaixo no `~/.bash_profile` (ou equivalente de sua preferencia) para criar um "comando" chamado **sid**. Repare que o diretório `~/.sidroot` é montado como volume, esse é o diretório onde mantenho arquivos de configuração do usuário root do ambiente conteinerizado, além do diretório do trabalho de empacotamento `PKGS`.

```shell
function sid {
  if podman container ls -af name=sid | grep sid; then
     podman container stop sid && \
     podman container rm sid
  fi
  xhost local:$USER
  podman container run -ti --rm --name sid \
                       --hostname sid \
                       -e DISPLAY \
                       --device /dev/snd \
                       -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
                       -v "$HOME/.sidroot":/root:z \
                       --security-opt seccomp=unconfined \
                       localhost/sid:latest
}
```

Obs: Perceba que nesse exemplo eu vou trabalhar com apenas um container de cada vez, por isso defino o nome como "sid" e a função destrói o container caso exista.

## License

GPLv3 or later.
