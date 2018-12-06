/*
 Author: Asher Bond
 (C) Elastic Provisioner 2011-2018

 Elastic Provisioner is a runtime bootstrapping utility for automated deployment of software application
 code atop a virtual or paravirtual machine or even a physical machine.. if that's what you're into.

 eprov also serves as the client of a Test-Driven-DevOps PaaS framework for distributed systems developers.

 Please read the License (AGPL v3)
 https://api.elasticprovisioner.com/LICENSE-AGPLv3.txt
 or
 https://www.gnu.org/licenses/agpl-3.0.de.html

 To install Elastic Provisioner:
 curl https://api.elasticprovisioner.com/install-eprov | bash

 A STRAP is a Service Template Running A Process
 A STRAP may be licensed to you under similar or different terms.
 A STRAP may be licensed to the public under AGPLv3 or a more permissive license such as LGPL or BSD or GNU or Apache License.
 A provisioner may invoke the STRAP at his or her own risk via eprov <strap> or gitstrapped <strap>

 To install gitstrapped:
 curl https://api.gitstrapped.com/install-gitstrapped | bash

 Please also join me in support of the Electronic Frontier Foundation (Defending Your Rights In The Digital World)
 https://www.eff.org/

 to compile this library:
 gcc -c eprov.c

 or #include "eprov.h" and compile with your main c program:
 gcc -o main_program main_program.c eprov.c
*/
#include "eprov.h"
#include <string.h>
#include <stdlib.h>
#include <sys/wait.h>

int eprov(char *strap)
{
    char invocation[4096] = "eprov ";
    strcat(invocation, strap);
    int status = system(invocation);
    if (status != -1) { 
        int e_status = WEXITSTATUS(status);
        return(e_status);
    }
    else {
        return(status);
    }
}


