## build openssl libs for Linux / Windows / macOS

```bash
# you need to have docker.io installed
git clone https://github.com/zoff99/gen_openssl_libs
cd gen_openssl_libs/

# build all libs, this will take some time
make

# find the generated includes here:
ls -al custom_docker/*/.build/include/openssl/

# find the generated static and shared libs here:
ls -al custom_docker/*/.build/lib/
```

<br>
Any use of this project's code by GitHub Copilot, past or present, is done
without our permission.  We do not consent to GitHub's use of this project's
code in Copilot.
<br>
No part of this work may be used or reproduced in any manner for the purpose of training artificial intelligence technologies or systems.
