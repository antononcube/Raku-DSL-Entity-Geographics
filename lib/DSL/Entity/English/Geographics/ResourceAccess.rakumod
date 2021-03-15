use DSL::Shared::Utilities::FuzzyMatching;
use DSL::Shared::Utilities::MetaSpecsProcessing;

class DSL::Entity::English::Geographics::ResourceAccess {
    ##========================================================
    ## Data
    ##========================================================
    my %countryAdjectiveToName;
    my Set $knownCountryNames;
    my Set $knownCountryNameWords;
    my Set $knownCountryAdjectives;
    my Set $knownCountryAdjectiveWords;

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
        #say "Number of calls to .make $numberOfCalls";

        #-----------------------------------------------------------
        my $fileName = %?RESOURCES<CountryNames.txt>;

        my Str @countryNames = $fileName.lines;

        $knownCountryNames = Set(@countryNames.map(*.lc));

        $knownCountryNameWords = Set(@countryNames.map({ $_.split(/\h+/) }).flat.trim.lc);

        #-----------------------------------------------------------
        $fileName = %?RESOURCES<CountryAdjectiveToName.csv>;

        my Str @adjNamPairs = $fileName.lines;

        %countryAdjectiveToName = @adjNamPairs.map({ $_.split(',') }).flat;

        %countryAdjectiveToName = %countryAdjectiveToName.keys.map(*.lc) Z=> %countryAdjectiveToName.values;

        $knownCountryAdjectives = Set(%countryAdjectiveToName);

        $knownCountryAdjectiveWords = Set(%countryAdjectiveToName.keys.map({ $_.split(/h+/) }).flat);

        self
    }

    ##========================================================
    ## Access
    ##========================================================
    method known-country-name-word (Str:D $word, Bool :$bool = True, Bool :$warn = True) {
        known-string($knownCountryNameWords, $word, :$bool, :$warn)
    }

    #-----------------------------------------------------------
    method known-country-name(Str:D $phrase, Bool :$bool = True, Bool :$warn = True) {
        $phrase (elem) $knownCountryAdjectives ?? False !! known-phrase($knownCountryNames, $knownCountryNameWords, $phrase, :$bool, :$warn)
    }

    #-----------------------------------------------------------
    method known-country-adjective(Str:D $phrase, Bool :$bool = True, Bool :$warn = True) {
        $phrase (elem) $knownCountryNames ?? False !! known-phrase($knownCountryAdjectives, $knownCountryAdjectiveWords, $phrase, :$bool, :$warn)
    }

    #-----------------------------------------------------------
    method country-adjective-to-name(Str:D $phrase, Bool :$warn = True) {
        %countryAdjectiveToName{$phrase}
    }

}
