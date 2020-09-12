#gcc taken
sim-bpred -bpred taken -max:inst 200000000 ../../../cc1.ss -O2 ./cccp.i
#gcc no taken
sim-bpred -bpred nottaken -max:inst 200000000 ../../../cc1.ss -O2 ./cccp.i
#gcc bimod(512)
sim-bpred -bpred:bimod 512 -max:inst 200000000 ../../../cc1.ss -O2 ./cccp.i
# gcc Bimod(1024) 
sim-bpred -bpred:bimod 1024 -max:inst 200000000 ../../../cc1.ss -O2 ./cccp.i
#gcc Two level (1,1024,8,0)
sim-bpred -bpred:2lev 1 1024 8 0 -max:inst 200000000 ../../../cc1.ss -O2 ./cccp.i
#gcc Two level (1,64,6,1)
sim-bpred -bpred:2lev 1 64 6 1 -max:inst 200000000 ../../../cc1.ss -O2 ./cccp.i

#mcf taken
sim-bpred -bpred taken -max:inst 2000000000 ./mcf.ss ./inp.in
#mcf no taken
sim-bpred -bpred nottaken -max:inst 2000000000 ./mcf.ss ./inp.in
#mcf bimod(512)
sim-bpred -bpred:bimod 512 -max:inst 200000000 ./mcf.ss ./inp.in
#mcf Bimod(1024)
sim-bpred -bpred:bimod 1024 -max:inst 200000000 ./mcf.ss ./inp.in
#mcf Two level (1,1024,8,0)
sim-bpred -bpred:2lev 1 1024 8 0 -max:inst 200000000 ./mcf.ss ./inp.in
#mcf Two level (1,64,6,1)
sim-bpred -bpred:2lev 1 64 6 1 -max:inst 200000000 ./mcf.ss ./inp.in

#vortex taken
sim-bpred -bpred taken -max:inst 2000000000 ../../../../../Simplescalar-master/spec95-little/vortex.ss ./bendian.raw ./bendian.rnv  ./bendian.wnv  ./lendian.raw  ./lendian.rnv  ./lendian.wnv  ./persons.1k
#vortex no taken
sim-bpred -bpred nottaken -max:inst 2000000000 ../../../../../Simplescalar-master/spec95-little/vortex.ss ./bendian.raw ./bendian.rnv  ./bendian.wnv  ./lendian.raw  ./lendian.rnv  ./lendian.wnv  ./persons.1k
#vortex bimod(512)
sim-bpred -bpred:bimod 512 -max:inst 200000000 ../../../../../Simplescalar-master/spec95-little/vortex.ss ./bendian.raw ./bendian.rnv  ./bendian.wnv  ./lendian.raw  ./lendian.rnv  ./lendian.wnv  ./persons.1k
#vortex Bimod(1024)
sim-bpred -bpred:bimod 1024 -max:inst 200000000 ../../../../../Simplescalar-master/spec95-little/vortex.ss ./bendian.raw ./bendian.rnv  ./bendian.wnv  ./lendian.raw  ./lendian.rnv  ./lendian.wnv  ./persons.1k
#vortex Two level (1,1024,8,0)
sim-bpred -bpred:2lev 1 1024 8 0 -max:inst 200000000 ./vortex.ss ./bendian.raw ./bendian.rnv  ./bendian.wnv  ./lendian.raw  ./lendian.rnv  ./lendian.wnv  ./persons.1k
#vortex Two level (1,64,6,1)
sim-bpred -bpred:2lev 1 64 6 1 -max:inst 200000000 ../../../../../Simplescalar-master/spec95-little/vortex.ss ./bendian.raw ./bendian.rnv  ./bendian.wnv  ./lendian.raw  ./lendian.rnv  ./lendian.wnv  ./persons.1k

#vpr taken
sim-bpred -bpred taken -max:inst 2000000000 ./vpr.ss ./arch.in ./net.in ./place.in
#vpr no taken
sim-bpred -bpred nottaken -max:inst 2000000000 -max:inst 200000000 ./vpr.ss ./arch.in ./net.in ./place.in
#vpr bimod(512)
sim-bpred -bpred:bimod 512 -max:inst 200000000 ./vpr.ss ./arch.in ./net.in ./place.in
#vpr Bimod(1024)
sim-bpred -bpred:bimod 1024 -max:inst 200000000 ./vpr.ss ./arch.in ./net.in ./place.in
#vpr Two level (1,1024,8,0)
sim-bpred -bpred:2lev 1 1024 8 0 -max:inst 200000000 ./vpr.ss ./arch.in ./net.in ./place.in
#vpr Two level (1,64,6,1)
sim-bpred -bpred:2lev 1 64 6 1 -max:inst 200000000  ./vpr.ss ./arch.in ./net.in ./place.in



