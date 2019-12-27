#!/bin/bash

curl -X POST "/home/travis/build/AlexeyYa/origin/build/HelloWorld-0.1.$TRAVIS_BUILD_NUMBER-Linux.deb" -alexeyya:$BINTRAY_KEY "https://api.bintray.com/content/alexeyya/helloworld/origin/$TRAVIS_BUILD_NUMBER/HelloWorld-0.1.$TRAVIS_BUILD_NUMBER-Linux.deb;deb_distribution=trusty;deb_component=main;deb_architecture=amd64;publish=1"
