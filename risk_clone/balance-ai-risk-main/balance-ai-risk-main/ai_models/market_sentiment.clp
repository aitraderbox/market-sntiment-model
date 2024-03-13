;template for position data
(deftemplate position-data
(slot ot_pos_dealid)
(slot ot_instr_name)
(slot ot_instr_id)
(slot ot_instrument_type)
(slot ot_pos_direction)
(slot ot_pos_opening)
(slot ot_pos_limit)
(slot ot_pos_stop)
(slot ot_instr_lotsize)
(slot ot_pos_contractsize)
(slot ot_pos_size)
(slot ot_instr_offer)
(slot ot_instr_bid)
(slot ot_pos_controlled)
(slot ot_pos_weight)
(slot ot_pos_cc)
(slot ot_pos_exchange)
(slot ot_pos_margin)
(slot ot_instr_type)
(slot ot_risk_check)
)

;template for correlation data
(deftemplate correlation-data
(slot ot_instr_id_1)
(slot ot_instr_id_2)
(slot corr-is)
)

;template for risk data
(deftemplate risk-data
(slot risk-is)
(slot ot_pos_dealid)
(slot name_1)
(slot param_1)
(slot param_2)
(slot param_3)
(slot param_4)
(slot param_5)
(slot param_6)
)

;template for indicator data, with a one slot for sentiment for sma
(deftemplate indicator-data
(slot ot_instr_name )
(slot ot_instr_id )
(slot ot_indicator_type )
(slot ot_indicator_value )
(slot ot_instr_sentiment)
)

;template for signal data
(deftemplate signal-data
(slot ot_instr_name )
(slot ot_indicator_first )
(slot ot_indicator_second )
(slot ot_instr_signal)
)

;rule sma-above-lma
(defrule sma-above-lma
(position-data (ot_pos_dealid ?deal)(ot_instr_name ?name))
(indicator-data (ot_instr_name ?name2)(ot_indicator_type sma)(ot_indicator_value ?sma))
(indicator-data (ot_instr_name ?name3)(ot_indicator_type lma)(ot_indicator_value ?lma))
(test (eq ?name ?name2))
(test (eq ?name2 ?name3))
(test (neq nil ?sma))
(test (neq nil ?lma))
(test (>= (- ?sma ?lma) 0) )
=>
(assert (signal-data (ot_instr_name ?name)(ot_indicator_first sma)(ot_indicator_second lma)(ot_instr_signal sma-above-lma))))

;rule sma-below-lma
(defrule sma-below-lma
(position-data (ot_pos_dealid ?deal)(ot_instr_name ?name))
(indicator-data (ot_instr_name ?name2)(ot_indicator_type sma)(ot_indicator_value ?sma))
(indicator-data (ot_instr_name ?name3)(ot_indicator_type lma)(ot_indicator_value ?lma))
(test (eq ?name ?name2))
(test (eq ?name2 ?name3))
(test (neq nil ?sma))
(test (neq nil ?lma))
(test (> (- ?lma ?sma) 0) )
=>
(assert (signal-data (ot_instr_name ?name)(ot_indicator_first sma)(ot_indicator_second lma)(ot_instr_signal sma-below-lma))))

;rule rsi-above-60
(defrule rsi-above-60
(position-data (ot_pos_dealid ?deal)(ot_instr_name ?name))
(indicator-data (ot_instr_name ?name1)(ot_indicator_type rsi)(ot_indicator_value ?rsi))
(test (eq ?name ?name1))
(test (neq nil ?rsi))
(test (>= ?rsi 60.0) )
=>
(assert (signal-data (ot_instr_name ?name)(ot_indicator_first rsi)(ot_instr_signal rsi-above-60))))

;rule rsi-below-60
(defrule rsi-below-60
(position-data (ot_pos_dealid ?deal)(ot_instr_name ?name))
(indicator-data (ot_instr_name ?name1)(ot_indicator_type rsi)(ot_indicator_value ?rsi))
(test (eq ?name ?name1))
(test (neq nil ?rsi))
(test (< ?rsi 60.0) )
=>
(assert (signal-data (ot_instr_name ?name)(ot_indicator_first rsi)(ot_instr_signal rsi-below-60))))

;rule rsi-above-50
(defrule rsi-above-50
(position-data (ot_pos_dealid ?deal)(ot_instr_name ?name))
(indicator-data (ot_instr_name ?name1)(ot_indicator_type rsi)(ot_indicator_value ?rsi))
(test (eq ?name ?name1))
(test (neq nil ?rsi))
(test (>= ?rsi 50.0) )
=>
(assert (signal-data (ot_instr_name ?name)(ot_indicator_first rsi)(ot_instr_signal rsi-above-50))))

;rule rsi-below-50
(defrule rsi-below-50
(position-data (ot_pos_dealid ?deal)(ot_instr_name ?name))
(indicator-data (ot_instr_name ?name1)(ot_indicator_type rsi)(ot_indicator_value ?rsi))
(test (eq ?name ?name1))
(test (neq nil ?rsi))
(test (< ?rsi 50.0) )
=>
(assert (signal-data (ot_instr_name ?name)(ot_indicator_first rsi)(ot_instr_signal rsi-below-50))))

;rule rsi-below-40
(defrule rsi-below-40
(position-data (ot_pos_dealid ?deal)(ot_instr_name ?name))
(indicator-data (ot_instr_name ?name1)(ot_indicator_type rsi)(ot_indicator_value ?rsi))
(test (eq ?name ?name1))
(test (neq nil ?rsi))
(test (< ?rsi 40.0) )
=>
(assert (signal-data (ot_instr_name ?name)(ot_indicator_first rsi)(ot_instr_signal rsi-below-40))))

;rule rsi-above-40
(defrule rsi-above-40
(position-data (ot_pos_dealid ?deal)(ot_instr_name ?name))
(indicator-data (ot_instr_name ?name1)(ot_indicator_type rsi)(ot_indicator_value ?rsi))
(test (eq ?name ?name1))
(test (neq nil ?rsi))
(test (>= ?rsi 40.0) )
=>
(assert (signal-data (ot_instr_name ?name)(ot_indicator_first rsi)(ot_instr_signal rsi-above-40))))

;rule price-above-ubb
(defrule price-above-ubb
(position-data (ot_pos_dealid ?deal)(ot_instr_name ?name)(ot_instr_offer ?offer))
(indicator-data (ot_instr_name ?name1)(ot_indicator_type ubb)(ot_indicator_value ?ubb))
(test (eq ?name ?name1))
(test (neq nil ?ubb))
(test (>= ?offer ?ubb) )
=>
(assert (signal-data (ot_instr_name ?name)(ot_indicator_first price)(ot_indicator_second ubb)(ot_instr_signal price-above-ubb))))

;rule price-below-ubb
(defrule price-below-ubb
(position-data (ot_pos_dealid ?deal)(ot_instr_name ?name)(ot_instr_offer ?offer))
(indicator-data (ot_instr_name ?name1)(ot_indicator_type ubb)(ot_indicator_value ?ubb))
(test (eq ?name ?name1))
(test (neq nil ?ubb))
(test (< ?offer ?ubb) )
=>
(assert (signal-data (ot_instr_name ?name)(ot_indicator_first price)(ot_indicator_second ubb)(ot_instr_signal price-below-ubb))))

;rule price-below-lbb
(defrule price-below-lbb
(position-data (ot_pos_dealid ?deal)(ot_instr_name ?name)(ot_instr_offer ?offer))
(indicator-data (ot_instr_name ?name1)(ot_indicator_type lbb)(ot_indicator_value ?lbb))
(test (eq ?name ?name1))
(test (neq nil ?lbb))
(test (<= ?offer ?lbb) )
=>
(assert (signal-data (ot_instr_name ?name)(ot_indicator_first price)(ot_indicator_second lbb)(ot_instr_signal price-below-lbb))))

;rule price-above-lbb
(defrule price-above-lbb
(position-data (ot_pos_dealid ?deal)(ot_instr_name ?name)(ot_instr_offer ?offer))
(indicator-data (ot_instr_name ?name1)(ot_indicator_type lbb)(ot_indicator_value ?lbb))
(test (eq ?name ?name1))
(test (neq nil ?lbb))
(test (> ?offer ?lbb) )
=>
(assert (signal-data (ot_instr_name ?name)(ot_indicator_first price)(ot_indicator_second lbb)(ot_instr_signal price-above-lbb))))

;rule macd-above-signal
(defrule macd-above-signal
(position-data (ot_pos_dealid ?deal)(ot_instr_name ?name))
(indicator-data (ot_instr_name ?name1)(ot_indicator_type macd)(ot_indicator_value ?macd))
(indicator-data (ot_instr_name ?name2)(ot_indicator_type macd-signal)(ot_indicator_value ?signal))
(test (eq ?name ?name1))
(test (eq ?name ?name2))
(test (neq nil ?macd))
(test (neq nil ?signal))
(test (>= ?macd ?signal) )
=>
(assert (signal-data (ot_instr_name ?name)(ot_indicator_first macd)(ot_indicator_second macd-signal)(ot_instr_signal macd-above-signal))))


;rule macd-below-signal
(defrule macd-below-signal
(position-data (ot_pos_dealid ?deal)(ot_instr_name ?name))
(indicator-data (ot_instr_name ?name1)(ot_indicator_type macd)(ot_indicator_value ?macd))
(indicator-data (ot_instr_name ?name2)(ot_indicator_type macd-signal)(ot_indicator_value ?signal))
(test (eq ?name ?name1))
(test (eq ?name ?name2))
(test (neq nil ?macd))
(test (neq nil ?signal))
(test (< ?macd ?signal) )
=>
(assert (signal-data (ot_instr_name ?name)(ot_indicator_first macd)(ot_indicator_second macd-signal)(ot_instr_signal macd-below-signal))))

;rule strong-uptrend
(defrule strong-uptrend
(position-data (ot_pos_dealid ?deal)(ot_instr_name ?name)(ot_instr_id ?id)(ot_pos_direction ?dir)(ot_risk_check ?check))
(signal-data (ot_instr_name ?name1)(ot_instr_signal price-above-ubb))
(signal-data (ot_instr_name ?name2)(ot_instr_signal sma-above-lma))
(signal-data (ot_instr_name ?name3)(ot_instr_signal rsi-above-60))
(signal-data (ot_instr_name ?name4)(ot_instr_signal macd-above-signal))
(test (eq ?check true))
(test (eq ?id ?name1))
(test (eq ?id ?name2))
(test (eq ?id ?name3))
(test (eq ?id ?name4))
 =>
(assert (risk-data (risk-is strong-uptrend)(ot_pos_dealid ?deal)(name_1 ?id)(param_4 ?dir)(param_5 ?name)(param_6 signal))))

;rule strong-downtrend
(defrule strong-downtrend
(position-data (ot_pos_dealid ?deal)(ot_instr_name ?name)(ot_instr_id ?id)(ot_pos_direction ?dir)(ot_risk_check ?check))
(signal-data (ot_instr_name ?name1)(ot_instr_signal price-below-lbb))
(signal-data (ot_instr_name ?name2)(ot_instr_signal sma-below-lma))
(signal-data (ot_instr_name ?name3)(ot_instr_signal rsi-below-40))
(signal-data (ot_instr_name ?name4)(ot_instr_signal macd-below-signal))
(test (eq ?check true))
(test (eq ?id ?name1))
(test (eq ?id ?name2))
(test (eq ?id ?name3))
(test (eq ?id ?name4))
 =>
(assert (risk-data (risk-is strong-downtrend)(ot_pos_dealid ?deal)(param_4 ?dir)(param_5 ?id)(name_1 ?id)(param_6 signal))))


;rule uptrend
(defrule uptrend
(position-data (ot_pos_dealid ?deal)(ot_instr_name ?name)(ot_instr_id ?id)(ot_pos_direction ?dir)(ot_risk_check ?check))
(not (risk-data (risk-is strong-uptrend)(name_1 ?name)))
(signal-data (ot_instr_name ?name1)(ot_instr_signal price-above-lbb))
(signal-data (ot_instr_name ?name2)(ot_instr_signal sma-above-lma))
(signal-data (ot_instr_name ?name3)(ot_instr_signal rsi-above-50))
(signal-data (ot_instr_name ?name4)(ot_instr_signal macd-above-signal))
(test (eq ?check true))
(test (eq ?id ?name1))
(test (eq ?id ?name2))
(test (eq ?id ?name3))
(test (eq ?id ?name4))
 =>
(assert (risk-data (risk-is uptrend)(ot_pos_dealid ?deal)(name_1 ?id)(param_4 ?dir)(param_5 ?name)(param_6 signal))))

;rule downtrend
(defrule downtrend
(position-data (ot_pos_dealid ?deal)(ot_instr_name ?name)(ot_instr_id ?id)(ot_pos_direction ?dir)(ot_risk_check ?check))
(not (risk-data (risk-is strong-downtrend)(name_1 ?name)))
(signal-data (ot_instr_name ?name1)(ot_instr_signal price-below-ubb))
(signal-data (ot_instr_name ?name2)(ot_instr_signal sma-below-lma))
(signal-data (ot_instr_name ?name3)(ot_instr_signal rsi-below-50))
(signal-data (ot_instr_name ?name4)(ot_instr_signal macd-below-signal))
(test (eq ?check true))
(test (eq ?id ?name1))
(test (eq ?id ?name2))
(test (eq ?id ?name3))
(test (eq ?id ?name4))
 =>
(assert (risk-data (risk-is downtrend)(ot_pos_dealid ?deal)(param_4 ?dir)(param_5 ?id)(name_1 ?id)(param_6 signal))))

;rule downtrend-pullback
(defrule downtrend-pullback
(position-data (ot_pos_dealid ?deal)(ot_instr_name ?name)(ot_instr_id ?id)(ot_pos_direction ?dir)(ot_risk_check ?check))
(signal-data (ot_instr_name ?name1)(ot_instr_signal price-above-lbb))
(signal-data (ot_instr_name ?name2)(ot_instr_signal sma-below-lma))
(signal-data (ot_instr_name ?name3)(ot_instr_signal rsi-below-50))
(signal-data (ot_instr_name ?name4)(ot_instr_signal macd-above-signal))
(test (eq ?check true))
(test (eq ?id ?name1))
(test (eq ?id ?name2))
(test (eq ?id ?name3))
(test (eq ?id ?name4))
 =>
(assert (risk-data (risk-is downtrend-pullback)(ot_pos_dealid ?deal)(param_4 ?dir)(param_5 ?id)(name_1 ?id)(param_6 signal))))

;rule uptrend-pullback
(defrule uptrend-pullback
(position-data (ot_pos_dealid ?deal)(ot_instr_name ?name)(ot_instr_id ?id)(ot_pos_direction ?dir)(ot_risk_check ?check))
(signal-data (ot_instr_name ?name1)(ot_instr_signal price-below-ubb))
(signal-data (ot_instr_name ?name2)(ot_instr_signal sma-above-lma))
(signal-data (ot_instr_name ?name3)(ot_instr_signal rsi-above-50))
(signal-data (ot_instr_name ?name4)(ot_instr_signal macd-below-signal))
(test (eq ?check true))
(test (eq ?id ?name1))
(test (eq ?id ?name2))
(test (eq ?id ?name3))
(test (eq ?id ?name4))
 =>
(assert (risk-data (risk-is uptrend-pullback)(ot_pos_dealid ?deal)(name_1 ?id)(param_4 ?dir)(param_5 ?name)(param_6 signal))))

(defrule range
(position-data (ot_pos_dealid ?deal)(ot_instr_name ?name)(ot_instr_id ?id)(ot_pos_direction ?dir)(ot_risk_check ?check))
(not (risk-data (name_1 ?id)(param_6 ?value&:(eq ?value signal))))
=>
(assert (risk-data (risk-is range)(name_1 ?id)(ot_pos_dealid ?deal)(param_4 ?dir)(param_5 ?id))))

