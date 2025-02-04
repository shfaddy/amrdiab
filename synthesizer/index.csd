<CsoundSynthesizer>

<CsOptions>

--omacro:synthesizer=/home/amrdiab/synthesizer
--smacro:nota=/home/amrdiab/music.nota

-odac

</CsOptions>

<CsInstruments>

#includestr "$synthesizer/header.part"
#includestr "$synthesizer/output.part"
#includestr "$synthesizer/note.part"

</CsInstruments>

<CsScore>

#includestr "$nota"

</CsScore>

</CsoundSynthesizer>
