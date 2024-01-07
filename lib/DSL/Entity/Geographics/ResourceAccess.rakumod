use DSL::Shared::Utilities::FuzzyMatching;
use DSL::Shared::Utilities::MetaSpecsProcessing;
use DSL::Shared::Entity::ResourceAccess;
use JSON::Fast;

class DSL::Entity::Geographics::ResourceAccess
        is DSL::Shared::Entity::ResourceAccess {

    my %.countryStateCity;

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

        self.countryStateCity = from-json(slurp(%?RESOURCES<CountryStateCity_EN.json>));

        return %resources;
    }

    #-----------------------------------------------------------
    # OVERRIDE-END
    #-----------------------------------------------------------
}
