let argv = new class {

depth = 0;
increment = 2;
octave = 2;
range = 4;

tempo = 105;
measure = 4;
length = 1000;

constructor ( ... argv ) { this .$ ( ... argv ) };

$ ( ... argv ) {

if ( ! argv .length )
return;

this [ argv .shift () ] = parseFloat ( argv .shift () );

return this .$ ( ... argv );

};

} ( ... process .argv .slice ( 2 ) );

let { depth, increment, octave, range, measure, tempo, length, track } = argv;

let steps = 2 ** ( 3 + depth );
let maqsum = new Array ( steps );

for ( let step of [ 0, 1/2 ] )
maqsum [ step * steps ] = octave;

octave += increment;

for ( let step of [ 1/8, 3/8, 6/8 ] )
maqsum [ step * steps ] = octave;

octave += increment;

maqsum [ .25 * steps ] = octave;

octave += increment;

for ( let level = 0; level < depth; level ++ ) {

for ( let division = 0, measure = 2 ** ( level + 4 ); division < measure; division += 2 ) {

let step = division * steps / measure;

if ( maqsum [ step ] === undefined )
maqsum [ step ] = octave;

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

maqsum .map ( ( octave, step ) => `i "note" [ $measure + ${ step }/${ steps } ] 1 "${ track }" ${ 12 + 12 * octave }` ) .join ( '\n' ),

'}'

] .join ( '\n\n' ) );
