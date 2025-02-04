let argv = new class {

depth = 0;
increment = 2;
octave = 2;
range = 4;

tempo = 105;
measure = 2;
length = 3600;

constructor ( ... argv ) { this .$ ( ... argv ) };

$ ( ... argv ) {

if ( ! argv .length )
return;

this [ argv .shift () ] = parseFloat ( argv .shift () );

return this .$ ( ... argv );

};

} ( ... process .argv .slice ( 2 ) );

let { depth, increment, octave, range, measure, tempo, length, track } = argv;

let base = 2;

let steps = 2 ** ( 3 + depth );
let malfuf = new Array ( steps );

malfuf [ 0 ] = octave; octave += increment;
malfuf [ steps * 1.5/4 ] = octave;
malfuf [ steps * 3/4 ] = octave; octave += increment;

for ( let level = 0; level < depth; level ++ ) {

for ( let division = 0, measure = 2 ** ( level + base ); division < measure; division += 2 ) {

let step = division * steps / measure;

if ( malfuf [ step ] === undefined )
malfuf [ step ] = octave;

}

octave += increment;

}

console .log ( [

`; steps ${ steps }`,
`; depth ${ depth }`,
`; increment ${ increment }`,

`i "output" 0 -1 "${ track }"`,

`t 0 ${ tempo }`,
`v ${ measure }`,

`{ ${ length } measure`,

malfuf .map ( ( octave, step ) => `i "note" [ $measure + ${ step }/${ steps } ] 1 "${ track }" ${ 12 + 12 * octave }` ) .join ( '\n' ),

'}'

] .join ( '\n\n' ) );
