use DSL::Shared::Utilities::FuzzyMatching;
use DSL::Shared::Utilities::MetaSpecsProcessing;
use DSL::Shared::Entity::ResourceAccess;

class DSL::Entity::Geographics::ResourceAccess
        is DSL::Shared::Entity::ResourceAccess {
    #-----------------------------------------------------------
    # OVERRIDE-START
    #-----------------------------------------------------------

    #| Override the parent class function in order to call
    #| DSL::Shared::Entity::ResourceAccess.make()
    #| with the correct file names.
    method get-resource-files( --> Hash) {

        # English
        my @fileNames = <Country Region>;
        my %fileNames1 = @fileNames.map({ $_ => $_ ~ 'NameToEntityID_EN.csv' });
        my %fileNames2 = @fileNames.map({ $_ ~ '-Adjective' => $_ ~ 'AdjectiveToEntityID_EN.csv' });
        my %resources = %fileNames1 , %fileNames2;
        %resources = %resources.map({ $_.key => %?RESOURCES{$_.value} });

        # Bulgarian
        %fileNames1 = @fileNames.map({ $_ => $_ ~ 'NameToEntityID_BG.csv' });
        %fileNames2 = @fileNames.map({ $_ ~ '-Adjective' => $_ ~ 'AdjectiveToEntityID_BG.csv' });
        my %resources-bg = %fileNames1 , %fileNames2;
        %resources-bg = %resources-bg.map({ $_.key ~ '-Bulgarian' => %?RESOURCES{$_.value} });

        # Combine
        %resources = %resources , %resources-bg;
        return %resources;
    }

    #-----------------------------------------------------------
    # OVERRIDE-END
    #-----------------------------------------------------------
}
