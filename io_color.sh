#!/usr/bin/env bash

function set_color {

  case "$2" in
  "red")
      echo -e "\033[31m$1\033[0m"
  ;;
  "green")
      echo -e "\033[32m$1\033[0m"
  ;;
  "yellow")
      echo -e "\033[33m$1\033[0m"
  ;;
  "blue")
      echo -e "\033[34m$1\033[0m"
  ;;
  "purple")
      echo -e "\033[35m$1\033[0m"
  ;;
  "sky-blue")
      echo -e "\033[36m$1\033[0m"
  ;;
  "white")
      echo -e "\033[37m$1\033[0m"
  ;;
  *)
      echo -e "\033[30m$1\033[0m"
  ;;
  esac

}

set_color "Hello world"
