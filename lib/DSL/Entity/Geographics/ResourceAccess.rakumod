use DSL::Shared::Utilities::FuzzyMatching;
use DSL::Shared::Utilities::MetaSpecsProcessing;
use DSL::Shared::Entity::ResourceAccess;
use JSON::Fast;

class DSL::Entity::Geographics::ResourceAccess
        is DSL::Shared::Entity::ResourceAccess {

    has %.countryStateCity;
    has Str $.defaultCountry is rw = 'United_States';
    has %.stateNameToAbbrv;
    has %.stateAbbrvToName;

    #-----------------------------------------------------------
    # OVERRIDE-START
    #-----------------------------------------------------------

    #| Override the parent class function in order to call
    #| DSL::Shared::Entity::ResourceAccess.make()
    #| with the correct file names.
    method get-resource-files( --> Hash) {

        # English
        my @fileNames = <City State Country Region>;
        my %fileNames1 = @fileNames.map({ $_ => $_ ~ 'NameToEntityID_EN.csv' });
        my %fileNames2 = @fileNames.grep(* ~~ /Country | Region/).map({ $_ ~ '-Adjective' => $_ ~ 'AdjectiveToEntityID_EN.csv' });
        my %resources = %fileNames1 , %fileNames2;
        %resources = %resources.map({ $_.key => %?RESOURCES{$_.value} });

        # Bulgarian
        %fileNames1 = @fileNames.map({ $_ => $_ ~ 'NameToEntityID_BG.csv' });
        %fileNames2 = @fileNames.grep(* ~~ /Country | Region/).map({ $_ ~ '-Adjective' => $_ ~ 'AdjectiveToEntityID_BG.csv' });
        my %resources-bg = %fileNames1 , %fileNames2;
        %resources-bg = %resources-bg.map({ $_.key ~ '-Bulgarian' => %?RESOURCES{$_.value} });

        # Combine
        %resources = %resources , %resources-bg;

        # Hierarchical data
        self.countryStateCity = from-json(slurp(%?RESOURCES<CountryStateCity_EN.json>));

        # State abbreviations
        # Instead of ingesting the resource data here we can principle use
        #   DSL::Entity::Geographics::resource-access-object().getNameToEntityID()<State>
        # But that structure is derived at later stages.
        my @dsStateNames = |slurp(%?RESOURCES<StateNameToEntityID_EN.csv>).lines.map({ $_.split(',') }).Array;
        @dsStateNames = @dsStateNames.map({ <Name ID>.Array Z=> $_.Array })>>.Hash.Array;
        my @dsStateNames2 = @dsStateNames.classify({ $_<ID> }).map({ $_.value.map(*<Name>).sort(*.chars) });
        self.stateNameToAbbrv = @dsStateNames2.map({ $_[1] => $_[0] }).Hash;
        self.stateAbbrvToName = self.stateNameToAbbrv.invert;

        return %resources;
    }

    #-----------------------------------------------------------
    # OVERRIDE-END
    #-----------------------------------------------------------
}
