<script>
    app.directive('valRequire', function() {
        return {
            require: 'ngModel',
            link: function(scope, element, attr, mCtrl) {
                function myValidation(value) {
                    console.log(mCtrl);
                    if (value.indexOf("e") > -1) {
                        // mCtrl.$error = {charE: 'false'}
                        mCtrl.$setValidity('charE', true);
                        // mCtrl.message('charE', 'day là messs');
                    } else {
                        mCtrl.$setValidity('charE', false);
                        // mCtrl.$invalid = true;
                        // mCtrl.message('charE', 'day không là messs');
                        // mCtrl.$error = {charE: 'true'}
                    }
                    return value;
                }
                mCtrl.$parsers.push(myValidation);
            }
        };
    });
</script>
