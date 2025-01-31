<CsoundSynthesizer>

<CsOptions>

-odac

</CsOptions>

<CsInstruments>

sr = 48000
ksmps = 32
nchnls = 2
0dbfs = 1


opcode shmix, 0, a

aNote xin

STrack sprintf "%d.%d", int ( p1 ), frac ( p1 ) * 10

chnmix aNote, STrack

iFraction random .1, .9

p1 init int ( p1 ) + iFraction

prints "#shmix %s\n", STrack

endop

alwayson "clock"

gkClock init 0

gkTempo init 210

gkBeat init 60 / i ( gkTempo )

gkMeasure init 8

instr clock

gkBeat = 60 / gkTempo

kClock metro 1 / gkBeat

if kClock == 1 then

gkClock = abs ( gkClock ) + 1

else

gkClock = - abs ( gkClock )

endif

endin

instr 1, 2

STrack sprintf "%d.%d", frac ( p1 ) * 1000, p1

prints "#sh%f %s\n", p1, STrack

aNote chnget STrack

aNote clip aNote, 1, 1

iDistance random 0, 13

;aNote *= 1/2^iDistance

outch int ( p1 ), aNote

chnclear STrack

endin

instr 3

if gkClock > 0 && gkClock % gkMeasure == p4 then

kChannel = 1

while kChannel <= 2 do

schedulek int ( frac ( p1 ) * 1000 ) + kChannel / 10, 0, 1

kChannel += 1

od

endif

endin

alwayson 1.060
alwayson 2.060

alwayson 3.0600, 0
alwayson 3.0601, 1
alwayson 3.0603, 3
alwayson 3.0604, 4
alwayson 3.0606, 6

instr 60

iRhythm random 5, 8

p3 /= 2^( int ( iRhythm ) )

iAttack random 0, 8
iDecay random 1, int ( iAttack )
iSustain random 0, 3
iRelease random 0, 4

aAmplitude madsr p3/2^iAttack, p3/2^iDecay, 1/2^iSustain, p3/2^iRelease

iDetune random 0, 47

iNote init int ( p1 ) + int ( iDetune ) / 4

iFrequency init cpsmidinn ( iNote )

iSweep random 0, 13

aFrequency poscil iFrequency, 2^( int ( iSweep ) )

iShape random 0, 2
iShape init int ( iShape )

if iShape == 0 then

aNote poscil aAmplitude, aFrequency

else

aClip random 0, 1
aSkew random 0, 1

aNote squinewave aFrequency, aClip, aSkew

aBand random 20, 2^5

aNote butterbp aNote, aFrequency, aFrequency / aBand

aNote *= aAmplitude

endif

shmix aNote

endin

</CsInstruments>

</CsoundSynthesizer>
