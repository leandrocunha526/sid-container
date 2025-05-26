# Docker/Podman Sid

O Dockerfile foi escrito baseado no "Guia Rápido de Empacotamento de Software no Debian" de João Eriberto Mota Filho, disponível em debianet.com.br.

A inspiração para compartilhar esse Dockerfile veio de assistir a palestra [Empacotamento Debian com Docker](https://www.youtube.com/watch?v=G3zdpXAlYq0) do @d4n1.

## Build da imagem

```console
podman build -t sid .
```

Obs: Use docker ao invés de podman se for o caso.

## Criar container com uma Shell Function

Adicione as linhas abaixo no `~/.bash_profile` (ou equivalente de sua preferencia) para criar um "comando" chamado **sid**. Repare que o diretório `~/.sidroot` é montado como volume, esse é o diretório onde mantenho arquivos de configuração do usuário root do ambiente conteinerizado, além do diretório do trabalho de empacotamento `PKGS`.

```txt
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
