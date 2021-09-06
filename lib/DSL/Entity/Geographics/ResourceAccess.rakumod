use DSL::Shared::Utilities::FuzzyMatching;
use DSL::Shared::Utilities::MetaSpecsProcessing;
use DSL::Shared::Entity::ResourceAccess;

class DSL::Entity::Geographics::ResourceAccess
        is DSL::Shared::Entity::ResourceAccess {
    #-----------------------------------------------------------
    # OVERRIDE-START
    #-----------------------------------------------------------

    ##========================================================
    ## Data
    ##========================================================
    my Hash %nameToEntityID{Str} = %();
    my Set %knownNames{Str} = %();
    my Set %knownNameWords{Str} = %();

    method getNameToEntityID( --> Hash) { %nameToEntityID }
    method getKnownNames( --> Hash) { %knownNames }
    method getKnownNameWords( --> Hash) { %knownNameWords }

    ##========================================================
    ## BUILD
    ##========================================================
    # We create a lexical variable in the class block that holds our single instance.
    my DSL::Entity::Geographics::ResourceAccess $instance = Nil;

    my Int $numberOfInstances = 0;

    method getNumberOfInstances() { $numberOfInstances }

    my Int $numberOfMakeCalls = 0;

    method getNumberOfMakeCalls() { $numberOfMakeCalls }

    method new {!!!}

    submethod instance {

        $instance = DSL::Entity::Geographics::ResourceAccess.bless unless $instance;

        if $numberOfInstances == 0 {
            $instance.make()
        }

        $numberOfInstances += 1;

        $instance
    }

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
