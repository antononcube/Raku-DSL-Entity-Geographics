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
        my @fileNames = <Country Region>;
        my %fileNames1 = @fileNames.map({ $_ => $_ ~ 'NameToEntityID_EN.csv' });
        my %fileNames2 = @fileNames.map({ $_ ~ '-Adjective' => $_ ~ 'AdjectiveToEntityID_EN.csv' });
        my %resources = %fileNames1 , %fileNames2;
        %resources = %resources.map({ $_.key => %?RESOURCES{$_.value} });
        return %resources;
    }

    #-----------------------------------------------------------
    # OVERRIDE-END
    #-----------------------------------------------------------
}
