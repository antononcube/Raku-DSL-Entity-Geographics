use DSL::Shared::Utilities::FuzzyMatching;
use DSL::Shared::Utilities::MetaSpecsProcessing;

class DSL::Entity::English::Geographics::ResourceAccess {
    ##========================================================
    ## Data
    ##========================================================
    my Hash %adjectiveToName{Str};
    my Set %knownNames{Str};
    my Set %knownNameWords{Str};
    my Set %knownAdjectives{Str};
    my Set %knownAdjectiveWords{Str};

    ##========================================================
    ## BUILD
    ##========================================================
    # We create a lexical variable in the class block that holds our single instance.
    my DSL::Entity::English::Geographics::ResourceAccess $instance = Nil;

    my Int $numberOfInstances = 0;

    method getNumberOfInstances() { $numberOfInstances }

    my Int $numberOfMakeCalls = 0;

    method getNumberOfMakeCalls() { $numberOfMakeCalls }

    method new {!!!}

    submethod instance {

        $instance = DSL::Entity::English::Geographics::ResourceAccess.bless unless $instance;

        if $numberOfInstances == 0 {
            $instance.make()
        }

        $numberOfInstances += 1;

        $instance
    }

    method make() {
        $numberOfMakeCalls += 1;
        #say "Number of calls to .make $numberOfMakeCalls";

        #-----------------------------------------------------------
        for <Country Region> -> $fn {
            my $fileName = %?RESOURCES{$fn ~ 'Names.txt'};
            my Str @countryNames = $fileName.lines;
            %knownNames.push( $fn => Set( @countryNames.map(*.lc) ) );
            %knownNameWords.push( $fn => Set(@countryNames.map({ $_.split(/\h+/) }).flat.trim.lc) );
        }

        #-----------------------------------------------------------
        for <Country Region> -> $fn {
            my $fileName = %?RESOURCES{$fn ~ 'AdjectiveToName.csv'};
            my Str @adjNamPairs = $fileName.lines;

            my %adjRules = @adjNamPairs.map({ $_.split(',') }).flat;

            %adjRules = %adjRules.keys.map(*.lc) Z=> %adjRules.values;

            %adjectiveToName.push( $fn => %adjRules );

            %knownAdjectives.push( $fn => Set(%adjRules) );

            %knownAdjectiveWords.push( $fn => Set(%adjRules.keys.map({ $_.split(/h+/) }).flat) );
        }

        #-----------------------------------------------------------
        self
    }

    ##========================================================
    ## Access
    ##========================================================
    method known-name-word(Str:D $class, Str:D $word, Bool :$bool = True, Bool :$warn = True) {
        known-string(%knownNameWords{$class}, $word, :$bool, :$warn)
    }

    #-----------------------------------------------------------
    method known-name(Str:D $class, Str:D $phrase, Bool :$bool = True, Bool :$warn = True) {
        ## If the name candidate $phrase is a known adjective, then return False/Nil.
        ##if $phrase (elem) %knownAdjectives{$class} {
        ##    $bool ?? False !! Nil
        ##} else {
        known-phrase(%knownNames{$class}, %knownNameWords{$class}, $phrase, :$bool, :$warn)
        ##}
    }

    #-----------------------------------------------------------
    method known-adjective(Str:D $class, Str:D $phrase, Bool :$bool = True, Bool :$warn = True) {
        ## If the adjective candidate $phrase is a known name, then return False/Nil.
        if $phrase (elem) %knownNames{$class} {
            $bool ?? False !! Nil
        } else {
            known-phrase(%knownAdjectives{$class}, %knownAdjectiveWords{$class}, $phrase, :$bool, :$warn)
        }
    }

    #-----------------------------------------------------------
    method adjective-to-name(Str:D $class, Str:D $phrase, Bool :$warn = False) {
        my $adj = self.known-adjective($class, $phrase, :!bool, :$warn);
        %adjectiveToName{$class}{$adj}
    }

}
