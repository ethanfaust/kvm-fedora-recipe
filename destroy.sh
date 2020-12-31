#!/bin/bash

name=template

rm -f ./disk ./fed-minimal.ks

virsh destroy ${name}
virsh undefine ${name}
