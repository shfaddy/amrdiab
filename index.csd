<CsoundSynthesizer>

<CsOptions>

-odac

</CsOptions>

<CsInstruments>

sr = 48000
ksmps = 32
nchnls = 1
0dbfs = 1

chnset 105, "clock/tempo"

chnset 4, "clock/measure"

chnset 16, "clock/steps"

opcode shtrack, 0, iii

iStep, iOctave, iRange xin

iNote init 12 * ( iOctave + 1 )

schedule "track", 0, -1, iStep, iNote

if iOctave < iRange then

shtrack iStep, iOctave + 1, iRange

endif

endop

alwayson "clock"

instr clock

kClock chnget "clock"

kTempo chnget "clock/tempo"
kMeasure chnget "clock/measure"
kSteps chnget "clock/steps"

kStep = ( kMeasure * ( 60 / kTempo ) ) / kSteps

kTick metro 1 / kStep

if kTick == 1 then

chnset abs ( kClock ) + 1, "clock"

else

chnset -abs ( kClock ), "clock"

endif

endin

instr output

iFraction random .1, .9
p1 += iFraction

STrack strget p4

aNote chnget STrack

aNote clip aNote, 1, 1

aAmplitude random 0, 1

iChannel init p5

outch iChannel, aNote * aAmplitude

if iChannel == nchnls then

chnclear STrack

else

schedule "output", p2, p3, STrack, iChannel + 1

endif

endin

instr track

iTrack random .1, .9

p1 init int ( p1 ) + iTrack

STrack sprintf "track:%f", iTrack

schedule "output", 0, -1, STrack, 1

kClock chnget "clock"
kSteps chnget "clock/steps"

if kClock > 0 && kClock % kSteps == p4 then

schedulek "note", 0, 1, STrack, p5

endif

endin

instr note

iFraction random .1, .9
p1 += iFraction

print p5

iRhythm random ( p5 / 12 ), ( p5 / 12 ) + 4

p3 /= 2^( int ( iRhythm ) )

iAttack random 0, 8
iDecay random 1, int ( iAttack )
iSustain random iRhythm + 2, iRhythm + 5
iRelease random 0, 4

aAmplitude madsr p3/2^iAttack, p3/2^iDecay, 1/2^iSustain, p3/2^iRelease

iDetune random 0, 47

iNote init p5 + int ( iDetune ) / 4

iFrequency init cpsmidinn ( iNote )

aSweep random -1, 1

aFrequency = iFrequency * cent ( aSweep * 1200 )

;aFrequency poscil iFrequency, 2^( int ( iSweep ) )

iShape random 0, 2
iShape init int ( iShape )

if iShape == 0 then

aNote poscil aAmplitude, aFrequency

else

aClip random 0, 1
aSkew random 0, 1

aNote squinewave aFrequency, aClip, aSkew

aNote *= aAmplitude

endif

kBand random 0, 2

aNote butterhp aNote, aFrequency / 2^int ( kBand )

aNote butterlp aNote, aFrequency * 2^int ( kBand )

STrack strget p4

chnmix aNote, STrack

endin

shtrack 0, 2, 5

shtrack 2, 4, 7

shtrack 4, 5, 23

shtrack 5, 5, 23

shtrack 6, 4, 7

shtrack 8, 2, 5

shtrack 10, 5, 23

shtrack 11, 5, 23

shtrack 12, 4, 7

shtrack 14, 5, 23

shtrack 15, 5, 23

</CsInstruments>

</CsoundSynthesizer>
