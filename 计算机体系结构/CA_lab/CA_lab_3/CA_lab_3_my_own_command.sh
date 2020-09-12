#例如:-cache:d11 dl1:2048:64:4:r，表示对一级数据cache进行配置，2048表示有2048组，64表示cache块大小为64 byte，4表示相联度为4，r表示替换策略为RANDOM。
#在此配置下，一级数据cache的容量为2048*64*4=512 KB。


#vpr capacity 2
sim-cache -cache:dl1 dl1:32:32:2:l -cache:dl2 none -cache:il2 none -max:inst 2000000000 ./vpr.ss ./arch.in ./net.in ./place.in
#vpr capacity 4
sim-cache -cache:dl1 dl1:64:32:2:l -cache:dl2 none -cache:il2 none -max:inst 2000000000 ./vpr.ss ./arch.in ./net.in ./place.in
#vpr capacity 8
sim-cache -cache:dl1 dl1:128:32:2:l -cache:dl2 none -cache:il2 none -max:inst 2000000000 ./vpr.ss ./arch.in ./net.in ./place.in
#vpr capacity 64
sim-cache -cache:dl1 dl1:1024:32:2:l -cache:dl2 none -cache:il2 none -max:inst 2000000000 ./vpr.ss ./arch.in ./net.in ./place.in

#vpr association 2
sim-cache -cache:dl1 dl1:512:32:2:l -cache:dl2 none -cache:il2 none -max:inst 2000000000 ./vpr.ss ./arch.in ./net.in ./place.in
#vpr association 4
sim-cache -cache:dl1 dl1:256:32:4:l -cache:dl2 none -cache:il2 none -max:inst 2000000000 ./vpr.ss ./arch.in ./net.in ./place.in
#vpr association 8
sim-cache -cache:dl1 dl1:128:32:8:l -cache:dl2 none -cache:il2 none -max:inst 2000000000 ./vpr.ss ./arch.in ./net.in ./place.in
#vpr association 16
sim-cache -cache:dl1 dl1:64:32:16:l -cache:dl2 none -cache:il2 none -max:inst 2000000000 ./vpr.ss ./arch.in ./net.in ./place.in
#vpr association 64
sim-cache -cache:dl1 dl1:16:32:64:l -cache:dl2 none -cache:il2 none -max:inst 2000000000 ./vpr.ss ./arch.in ./net.in ./place.in

#vpr Block Size 2
sim-cache -cache:dl1 dl1:2048:8:2:l -cache:dl2 none -cache:il2 none -max:inst 2000000000 ./vpr.ss ./arch.in ./net.in ./place.in
#vpr Block Size 4
sim-cache -cache:dl1 dl1:1024:16:2:l -cache:dl2 none -cache:il2 none -max:inst 2000000000 ./vpr.ss ./arch.in ./net.in ./place.in
#vpr Block Size 8
sim-cache -cache:dl1 dl1:512:32:2:l -cache:dl2 none -cache:il2 none -max:inst 2000000000 ./vpr.ss ./arch.in ./net.in ./place.in
#vpr Block Size 64
sim-cache -cache:dl1 dl1:256:64:2:l -cache:dl2 none -cache:il2 none -max:inst 2000000000 ./vpr.ss ./arch.in ./net.in ./place.in


#####################################################################################
#vortex capacity 2
sim-cache -cache:dl1 dl1:32:32:2:l -cache:dl2 none -cache:il2 none -max:inst 2000000000 ./vortex.ss bendian.raw ./bendian.rnv ./bendian.wnv ./lendian.raw ./lendian.rnv ./lendian.wnv ./persons.1k
#vortex capacity 4
sim-cache -cache:dl1 dl1:64:32:2:l -cache:dl2 none -cache:il2 none -max:inst 2000000000 ./vortex.ss bendian.raw ./bendian.rnv ./bendian.wnv ./lendian.raw ./lendian.rnv ./lendian.wnv ./persons.1k
#vortex capacity 8
sim-cache -cache:dl1 dl1:128:32:2:l -cache:dl2 none -cache:il2 none -max:inst 2000000000 ./vortex.ss bendian.raw ./bendian.rnv ./bendian.wnv ./lendian.raw ./lendian.rnv ./lendian.wnv ./persons.1k
#vortex capacity 64
sim-cache -cache:dl1 dl1:1024:32:2:l -cache:dl2 none -cache:il2 none -max:inst 2000000000 ./vortex.ss bendian.raw ./bendian.rnv ./bendian.wnv ./lendian.raw ./lendian.rnv ./lendian.wnv ./persons.1k

#vortex association 2
sim-cache -cache:dl1 dl1:512:32:2:l -cache:dl2 none -cache:il2 none -max:inst 2000000000 ./vortex.ss bendian.raw ./bendian.rnv ./bendian.wnv ./lendian.raw ./lendian.rnv ./lendian.wnv ./persons.1k
#vortex association 4
sim-cache -cache:dl1 dl1:256:32:4:l -cache:dl2 none -cache:il2 none -max:inst 2000000000 ./vortex.ss bendian.raw ./bendian.rnv ./bendian.wnv ./lendian.raw ./lendian.rnv ./lendian.wnv ./persons.1k
#vortex association 8
sim-cache -cache:dl1 dl1:128:32:8:l -cache:dl2 none -cache:il2 none -max:inst 2000000000 ./vortex.ss bendian.raw ./bendian.rnv ./bendian.wnv ./lendian.raw ./lendian.rnv ./lendian.wnv ./persons.1k
#vortex association 16
sim-cache -cache:dl1 dl1:64:32:16:l -cache:dl2 none -cache:il2 none -max:inst 2000000000 ./vortex.ss bendian.raw ./bendian.rnv ./bendian.wnv ./lendian.raw ./lendian.rnv ./lendian.wnv ./persons.1k
#vortex association 64
sim-cache -cache:dl1 dl1:16:32:64:l -cache:dl2 none -cache:il2 none -max:inst 2000000000 ./vortex.ss bendian.raw ./bendian.rnv ./bendian.wnv ./lendian.raw ./lendian.rnv ./lendian.wnv ./persons.1k

#vortex Block Size 2
sim-cache -cache:dl1 dl1:2048:8:2:l -cache:dl2 none -cache:il2 none -max:inst 2000000000 ./vortex.ss bendian.raw ./bendian.rnv ./bendian.wnv ./lendian.raw ./lendian.rnv ./lendian.wnv ./persons.1k
#vortex Block Size 4
sim-cache -cache:dl1 dl1:1024:16:2:l -cache:dl2 none -cache:il2 none -max:inst 2000000000 ./vortex.ss bendian.raw ./bendian.rnv ./bendian.wnv ./lendian.raw ./lendian.rnv ./lendian.wnv ./persons.1k
#vortex Block Size 8
sim-cache -cache:dl1 dl1:512:32:2:l -cache:dl2 none -cache:il2 none -max:inst 2000000000 ./vortex.ss bendian.raw ./bendian.rnv ./bendian.wnv ./lendian.raw ./lendian.rnv ./lendian.wnv ./persons.1k
#vortex Block Size 64
sim-cache -cache:dl1 dl1:256:64:2:l -cache:dl2 none -cache:il2 none -max:inst 2000000000 ./vortex.ss bendian.raw ./bendian.rnv ./bendian.wnv ./lendian.raw ./lendian.rnv ./lendian.wnv ./persons.1k


#####################################################################################
#mcf capacity 2
sim-cache -cache:dl1 dl1:32:32:2:l -cache:dl2 none -cache:il2 none -max:inst 2000000000 ./mcf.ss ./inp.in
#mcf capacity 4
sim-cache -cache:dl1 dl1:64:32:2:l -cache:dl2 none -cache:il2 none -max:inst 2000000000 ./mcf.ss ./inp.in
#mcf capacity 8
sim-cache -cache:dl1 dl1:128:32:2:l -cache:dl2 none -cache:il2 none -max:inst 2000000000 ./mcf.ss ./inp.in
#mcf capacity 64
sim-cache -cache:dl1 dl1:1024:32:2:l -cache:dl2 none -cache:il2 none -max:inst 2000000000 ./mcf.ss ./inp.in

#mcf association 2
sim-cache -cache:dl1 dl1:512:32:2:l -cache:dl2 none -cache:il2 none -max:inst 2000000000 ./mcf.ss ./inp.in
#mcf association 4
sim-cache -cache:dl1 dl1:256:32:4:l -cache:dl2 none -cache:il2 none -max:inst 2000000000 ./mcf.ss ./inp.in
#mcf association 8
sim-cache -cache:dl1 dl1:128:32:8:l -cache:dl2 none -cache:il2 none -max:inst 2000000000 ./mcf.ss ./inp.in
#mcf association 16
sim-cache -cache:dl1 dl1:64:32:16:l -cache:dl2 none -cache:il2 none -max:inst 2000000000 ./mcf.ss ./inp.in
#mcf association 64
sim-cache -cache:dl1 dl1:16:32:64:l -cache:dl2 none -cache:il2 none -max:inst 2000000000 ./mcf.ss ./inp.in

#mcf Block Size 2
sim-cache -cache:dl1 dl1:2048:8:2:l -cache:dl2 none -cache:il2 none -max:inst 2000000000 ./mcf.ss ./inp.in
#mcf Block Size 4
sim-cache -cache:dl1 dl1:1024:16:2:l -cache:dl2 none -cache:il2 none -max:inst 2000000000 ./mcf.ss ./inp.in
#mcf Block Size 8
sim-cache -cache:dl1 dl1:512:32:2:l -cache:dl2 none -cache:il2 none -max:inst 2000000000 ./mcf.ss ./inp.in
#mcf Block Size 64
sim-cache -cache:dl1 dl1:256:64:2:l -cache:dl2 none -cache:il2 none -max:inst 2000000000 ./mcf.ss ./inp.in


#####################################################################################
#bzip2 capacity 2
sim-cache -cache:dl1 dl1:32:32:2:l -cache:dl2 none -cache:il2 none -max:inst 2000000000 ./bzip2.ss ./control ./input.random
#bzip2 capacity 4
sim-cache -cache:dl1 dl1:64:32:2:l -cache:dl2 none -cache:il2 none -max:inst 2000000000 ./bzip2.ss ./control ./input.random
#bzip2 capacity  8
sim-cache -cache:dl1 dl1:128:32:2:l -cache:dl2 none -cache:il2 none -max:inst 2000000000 ./bzip2.ss ./control ./input.random
#bzip2 capacity 64
sim-cache -cache:dl1 dl1:1024:32:2:l -cache:dl2 none -cache:il2 none -max:inst 2000000000 ./bzip2.ss ./control ./input.random

#bzip2 association 2
sim-cache -cache:dl1 dl1:512:32:2:l -cache:dl2 none -cache:il2 none -max:inst 2000000000 ./bzip2.ss ./control ./input.random
#bzip2 association 4
sim-cache -cache:dl1 dl1:256:32:4:l -cache:dl2 none -cache:il2 none -max:inst 2000000000 ./bzip2.ss ./control ./input.random
#bzip2 association 8
sim-cache -cache:dl1 dl1:128:32:8:l -cache:dl2 none -cache:il2 none -max:inst 2000000000 ./bzip2.ss ./control ./input.random
#bzip2 association 16
sim-cache -cache:dl1 dl1:64:32:16:l -cache:dl2 none -cache:il2 none -max:inst 2000000000 ./bzip2.ss ./control ./input.random
#bzip2 association 64
sim-cache -cache:dl1 dl1:16:32:64:l -cache:dl2 none -cache:il2 none -max:inst 2000000000 ./bzip2.ss ./control ./input.random

#bzip2 Block Size 2
sim-cache -cache:dl1 dl1:2048:8:2:l -cache:dl2 none -cache:il2 none -max:inst 2000000000 ./bzip2.ss ./control ./input.random
#bzip2 Block Size 4
sim-cache -cache:dl1 dl1:1024:16:2:l -cache:dl2 none -cache:il2 none -max:inst 2000000000 ./bzip2.ss ./control ./input.random
#bzip2 Block Size 8
sim-cache -cache:dl1 dl1:512:32:2:l -cache:dl2 none -cache:il2 none -max:inst 2000000000 ./bzip2.ss ./control ./input.random
#bzip2 Block Size 64
sim-cache -cache:dl1 dl1:256:64:2:l -cache:dl2 none -cache:il2 none -max:inst 2000000000 ./bzip2.ss ./control ./input.random

