<finance>
    <div if={ state.response.error === true }>
        <strong>API returned error</strong>
    </div>
    <form>
        <div class="budget">
            <h2>Budget calculator</h2>
            <label>
                <h4>Deposit amount</h4>
                <div class="slider">
                    <button class="finance_button" data-name="deposit" onclick={ minus }>-</button>
                    <input id="deposit" type="range" min={ state.deposit.min } value={ state.deposit.value } max={ state.deposit.max } step={ state.deposit.step } oninput={ depositUpdate } onchange={ onChange } value={ state.deposit.value } />
                    <button class="finance_button" data-name="deposit" onclick={ plus }>+</button>
                </div>
            </label>
            <label>
                <h4>Repayment period</h4>
                <div class="slider">
                    <button class="finance_button" data-name="payments" onclick={ minus }>-</button>
                    <input id="payments" type="range" min={ state.payments.min } value={ state.payments.value } max={ state.payments.max } step={ state.payments.step } oninput={ paymentsUpdate } onchange={ onChange } value={ state.payments.value }/> 
                    <button class="finance_button" data-name="payments" onclick={ plus }>+</button> 
                </div>
            </label>
            <label>
                <h4>Credit rating</h4>
                <div class="slider">
                    <button class="credit_button" data-name="credit" onclick={ minus }>-</button>
                    <input id="credit" type="range" min={ state.credit.min } value={ state.credit.value } max={ state.credit.max } step={ state.credit.step } oninput={ creditUpdate } onchange={ onChange } value={ state.credit.value }/> 
                    <button class="credit_button" data-name="credit" onclick={ plus }>+</button> 
                </div>
            </label>
            <label>
                <h4>Typical annual mileage</h4>
                <div class="slider">
                    <button class="mileage_button" data-name="mileage" onclick={ minus }>-</button>
                    <input id="mileage" type="range" min={ state.mileage.min } value={ state.mileage.value } max={ state.mileage.max } step={ state.mileage.step } oninput={ mileageUpdate } onchange={ onChange } value={ state.mileage.value }/> 
                    <button class="mileage_button" data-name="mileage" onclick={ plus }>+</button> 
                </div>
            </label>
        </div>
        <div class="payments">
            <ul class="loan_type margin_bottom">
                <li>Loan type</li>
                <li class={ state.loanType === 'pcp' ? 'active' : ''} onclick={ loanType } data-loan="pcp">
                    PCP
                    <span class="help">?
                        <span>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum scelerisque commodo tortor eget porta. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Proin convallis tortor non lacus rhoncus, sit amet imperdiet risus rhoncus. Phasellus nisi ipsum, tincidunt vitae rhoncus at, facilisis eget urna.</span>
                    </span>
                </li>
                <li class={ state.loanType === 'hp' ? 'active' : ''} onclick={ loanType } data-loan="hp">
                    HP
                    <span class="help">?
                        <span>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum scelerisque commodo tortor eget porta. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Proin convallis tortor non lacus rhoncus, sit amet imperdiet risus rhoncus. Phasellus nisi ipsum, tincidunt vitae rhoncus at, facilisis eget urna.</span>
                    </span>
                </li>
            </ul>
            <div class="finance_split margin_bottom">
                <output name="deposit_amount">{ (state.calculating === true) ? 'Working...' : currency + ' ' + state.response.paymentAmount.toFixed(2) }</output>
                <h3>Per month</h3>
            </div>
            <div class="finance_split margin_bottom">
                <output name="payments_amount">{ state.payments.value }</output>
                <h3>Monthly payments</h3>
            </div>
            <div class="margin_bottom">
                <ul class="finance_split">
                    <li>{ (state.calculating === true) ? 'Working...' : state.response.rateOfInterest }</li>
                    <li>Interest rate</li>
                </ul>
                <ul class="finance_split">
                    <li><output name="deposit_amount">{ currency }{ state.deposit.value }</output></li>
                    <li>Deposit</li>
                </ul>
                <ul class="finance_split">
                    <li>{ creditMapping[state.credit.value] }</li>
                    <li>
                        Credit score
                        <span class="help">?
                            <span>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum scelerisque commodo tortor eget porta. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Proin convallis tortor non lacus rhoncus, sit amet imperdiet risus rhoncus. Phasellus nisi ipsum, tincidunt vitae rhoncus at, facilisis eget urna.</span>
                        </span>
                    </li>
                </ul>
                <ul class="finance_split">
                    <li><output name="mileage_amount">{ state.mileage.value } miles</output></li>
                    <li>Mileage</li>
                </ul>
            </div>

            <button>Apply for finance</button>
        </div>
    </form>



    <script>
        window.tag = this;

        this.currency = '£';

        this.creditMapping = {
            0: 'Shite',
            1: 'Not great',
            2: 'OK',
            3: 'Good',
            4: 'Bill Gates'
        }

        this.state = {
            calculating: true,
            car: 20000,
            credit: {
                value: 4,
                step: 1,
                min: 0,
                max: 4
            },
            deposit: {
                value: 2000,
                step: 100,
                min: 0,
                max: 2000
            },
            payments: {
                value: 12,
                step: 1,
                min: 12,
                max: 48
            },
            mileage: {
                value: 30000,
                step: 1000,
                min: 6000,
                max: 80000
            },
            loanType: 'pcp',
            monthly: 100,
            response: {}
        };

        this.XHRrequests = [];

        _int = function(value) {
            return parseInt(value, 10);
        }

        depositUpdate = function(e) {
            this.state.deposit.value = _int(e.currentTarget.value);
            //calculateMonthly();
        }

        paymentsUpdate = function(e) {
            this.state.payments.value = _int(e.currentTarget.value);
            //calculateMonthly();
        }

        creditUpdate = function(e) {
            this.state.credit.value = _int(e.currentTarget.value);
            //calculateMonthly();
        }

        mileageUpdate = function(e) {
            this.state.mileage.value = _int(e.currentTarget.value);
            //calculateMonthly(); 
        }

        loanType = function(e) {
            this.state.loanType = e.currentTarget.dataset.loan;
            calculateMonthly();
        }

        onChange = function(e) {
            console.log('onChange', this.state);
            this.state[e.currentTarget.id].value = _int(e.currentTarget.value);
            calculateMonthly();
        }

        minus = function(e) {
            e.preventDefault();

            var name =  e.currentTarget.dataset.name;
            this.state[name].value = this.state[name].value - this.state[name].step;
            this.state[name].value = (this.state[name].value < this.state[name].min) ? this.state[name].min : this.state[name].value;

            document.getElementById(name).value = this.state[name].value;

            calculateMonthly();
        }

        plus = function(e) {
            e.preventDefault();

            var name =  e.currentTarget.dataset.name;
            this.state[name].value = this.state[name].value + this.state[name].step;
            this.state[name].value = (this.state[name].value > this.state[name].max) ? this.state[name].max : this.state[name].value;

            document.getElementById(name).value = this.state[name].value;

            calculateMonthly();
        }

        _debounce = function(func, wait, immediate) {
            var timeout;
            return function() {
                var context = this, args = arguments;
                var later = function() {
                    timeout = null;
                    if (!immediate) func.apply(context, args);
                };
                var callNow = immediate && !timeout;
                clearTimeout(timeout);
                timeout = setTimeout(later, wait);
                if (callNow) func.apply(context, args);
            };
        };

        var immediate = true;

        getQuote = _debounce(function() {
            /*
                financeDeposit:21
                financePeriodMonths:48
                financeAnnualMileage:8000
                productAdvertId:540299
                quoteId:null
                quoteItemId:null
                productDefinitionId:736066
                totalPrice:6995.00
                deliveryMethodId:18
            */

            this.XHRrequests.forEach(function(xhr) {
                xhr.abort();
            });

            this.XHRrequests = [];

            var formData = {};

            formData['financeDeposit'] = this.state.deposit.value;
            formData['financePeriodMonths'] = this.state.payments.value;
            formData['financeAnnualMileage'] = this.state.mileage.value;
            formData['productAdvertId'] = 540299;
            formData['quoteId'] = null;
            formData['quoteItemId'] = null;
            formData['totalPrice'] = this.state.car;
            formData['deliveryMethodId'] = 18;

            var str = '';
            for (var key in formData) {
                if (str != "") {
                    str += "&";
                }
                str += key + "=" + encodeURIComponent(formData[key]);
            }

            var xhr = new XMLHttpRequest();
            xhr.addEventListener('load', function(data) {
                //cb(JSON.parse(data.currentTarget.responseText));
                console.log(JSON.parse(data.currentTarget.responseText));
                this.state.calculating = false;
                console.log(2, this.state.calculating);
                this.state.response = JSON.parse(data.currentTarget.responseText)[1];
                this.update();
            }.bind(this));

            xhr.open('POST', 'http://dev.buyacar.co.uk/finance/financeQuote.json', true);
            xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');

            xhr.send(str);

            this.XHRrequests.push(xhr);
        }.bind(this), 150, immediate);

        calculateMonthly = function(immediate) {
            this.state.calculating = true;
            console.log(1, this.state.calculating);
            getQuote();
        }.bind(this);

        calculateMonthly();

        immediate = false;

        this.on('mount', function() {
            document.getElementById('credit').value = this.state['credit'].value;
            document.getElementById('deposit').value = this.state['deposit'].value;
            document.getElementById('mileage').value = this.state['mileage'].value;
            document.getElementById('payments').value = this.state['payments'].value;
        }.bind(this));
    </script>

    <style scoped>
            :scope * {
                box-sizing: border-box;
            }

            :scope {
                background-color: #eeeeee;
                display: block;
                margin: 0 auto;
                max-width: 1127px;
                width: 100%;
            }

            :scope form > div {
                padding: 30px;
            }

            .left {
                float: left;
            }

            .right {
                float: right;
            }

            .margin_bottom {
                clear: both;
                float: left;
                margin-bottom: 20px;
                width: 100%;
            }

            .budget {
                float: left;
                width: 70%;
            }

            .payments {
                background-color: #dddddd;
                float: right;
                width: 30%;
            }

            h2 {
                margin-bottom: 30px;
            }

            .slider button {
                background-color: transparent;
                border-radius: 8px;
                border: 2px solid #666666;
                cursor: pointer;
                float: left;
                height: 24px;
                margin-right: 6px;
                outline: none;
                width: 24px;
                -webkit-appearance: none;
            }

            .slider button:last-child {
                margin-right: 0;
            }

            input[type="range"] {
                display: block;
                float: left;
                margin-right: 6px;
                width: calc(100% - 60px);
            }

            .help {
                background-color: #666;
                border-radius: 10px;
                color: #fff;
                cursor: default;
                float: right;
                font-size: 10px;
                line-height: 20px;
                height: 20px;
                position: relative;
                text-align: center;
                width: 20px;
                -webkit-user-select: none;
                -moz-user-select: none;
                -ms-user-select: none;
            }

            .help > span {
                background-color: #666;
                bottom: 30px;
                display: none;
                left: 50%;
                padding: 10px;
                position: absolute;
                transform: translateX(-50%);
                width: 200px;
                z-index: 1;
            }

            .help > span::after {
                background-color: #666;
                bottom: -5px;
                content: '';
                display: block;
                height: 10px;
                left: calc(50% - 5px);
                position: absolute;
                transform: rotate(45deg);
                width: 10px;
            }

            .help:hover > span {
                display: block;
            }

            .finance_split {
                clear: both;
            }

            .finance_split > * {
                float: left;
                width: 50%;
            }

            .loan_type li {
                float: left;
                width: 33.333333%;
                -webkit-user-select: none;
                -moz-user-select: none;
                -ms-user-select: none;
            }

            .loan_type li:nth-child(n+2) {
                cursor: pointer;
                padding-right: 20px;
            }

            .loan_type li.active {
                text-decoration: underline;
            }
    </style>
</finance>