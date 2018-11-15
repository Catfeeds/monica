package com.fh.entity;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class ExpInvoiceDistributeExample {
    protected String orderByClause;

    protected boolean distinct;

    protected List<Criteria> oredCriteria;

    public ExpInvoiceDistributeExample() {
        oredCriteria = new ArrayList<Criteria>();
    }

    public void setOrderByClause(String orderByClause) {
        this.orderByClause = orderByClause;
    }

    public String getOrderByClause() {
        return orderByClause;
    }

    public void setDistinct(boolean distinct) {
        this.distinct = distinct;
    }

    public boolean isDistinct() {
        return distinct;
    }

    public List<Criteria> getOredCriteria() {
        return oredCriteria;
    }

    public void or(Criteria criteria) {
        oredCriteria.add(criteria);
    }

    public Criteria or() {
        Criteria criteria = createCriteriaInternal();
        oredCriteria.add(criteria);
        return criteria;
    }

    public Criteria createCriteria() {
        Criteria criteria = createCriteriaInternal();
        if (oredCriteria.size() == 0) {
            oredCriteria.add(criteria);
        }
        return criteria;
    }

    protected Criteria createCriteriaInternal() {
        Criteria criteria = new Criteria();
        return criteria;
    }

    public void clear() {
        oredCriteria.clear();
        orderByClause = null;
        distinct = false;
    }

    protected abstract static class GeneratedCriteria {
        protected List<Criterion> criteria;

        protected GeneratedCriteria() {
            super();
            criteria = new ArrayList<Criterion>();
        }

        public boolean isValid() {
            return criteria.size() > 0;
        }

        public List<Criterion> getAllCriteria() {
            return criteria;
        }

        public List<Criterion> getCriteria() {
            return criteria;
        }

        protected void addCriterion(String condition) {
            if (condition == null) {
                throw new RuntimeException("Value for condition cannot be null");
            }
            criteria.add(new Criterion(condition));
        }

        protected void addCriterion(String condition, Object value, String property) {
            if (value == null) {
                throw new RuntimeException("Value for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value));
        }

        protected void addCriterion(String condition, Object value1, Object value2, String property) {
            if (value1 == null || value2 == null) {
                throw new RuntimeException("Between values for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value1, value2));
        }

        public Criteria andFidIsNull() {
            addCriterion("FID is null");
            return (Criteria) this;
        }

        public Criteria andFidIsNotNull() {
            addCriterion("FID is not null");
            return (Criteria) this;
        }

        public Criteria andFidEqualTo(Integer value) {
            addCriterion("FID =", value, "fid");
            return (Criteria) this;
        }

        public Criteria andFidNotEqualTo(Integer value) {
            addCriterion("FID <>", value, "fid");
            return (Criteria) this;
        }

        public Criteria andFidGreaterThan(Integer value) {
            addCriterion("FID >", value, "fid");
            return (Criteria) this;
        }

        public Criteria andFidGreaterThanOrEqualTo(Integer value) {
            addCriterion("FID >=", value, "fid");
            return (Criteria) this;
        }

        public Criteria andFidLessThan(Integer value) {
            addCriterion("FID <", value, "fid");
            return (Criteria) this;
        }

        public Criteria andFidLessThanOrEqualTo(Integer value) {
            addCriterion("FID <=", value, "fid");
            return (Criteria) this;
        }

        public Criteria andFidIn(List<Integer> values) {
            addCriterion("FID in", values, "fid");
            return (Criteria) this;
        }

        public Criteria andFidNotIn(List<Integer> values) {
            addCriterion("FID not in", values, "fid");
            return (Criteria) this;
        }

        public Criteria andFidBetween(Integer value1, Integer value2) {
            addCriterion("FID between", value1, value2, "fid");
            return (Criteria) this;
        }

        public Criteria andFidNotBetween(Integer value1, Integer value2) {
            addCriterion("FID not between", value1, value2, "fid");
            return (Criteria) this;
        }

        public Criteria andFyearIsNull() {
            addCriterion("FYear is null");
            return (Criteria) this;
        }

        public Criteria andFyearIsNotNull() {
            addCriterion("FYear is not null");
            return (Criteria) this;
        }

        public Criteria andFyearEqualTo(Integer value) {
            addCriterion("FYear =", value, "fyear");
            return (Criteria) this;
        }

        public Criteria andFyearNotEqualTo(Integer value) {
            addCriterion("FYear <>", value, "fyear");
            return (Criteria) this;
        }

        public Criteria andFyearGreaterThan(Integer value) {
            addCriterion("FYear >", value, "fyear");
            return (Criteria) this;
        }

        public Criteria andFyearGreaterThanOrEqualTo(Integer value) {
            addCriterion("FYear >=", value, "fyear");
            return (Criteria) this;
        }

        public Criteria andFyearLessThan(Integer value) {
            addCriterion("FYear <", value, "fyear");
            return (Criteria) this;
        }

        public Criteria andFyearLessThanOrEqualTo(Integer value) {
            addCriterion("FYear <=", value, "fyear");
            return (Criteria) this;
        }

        public Criteria andFyearIn(List<Integer> values) {
            addCriterion("FYear in", values, "fyear");
            return (Criteria) this;
        }

        public Criteria andFyearNotIn(List<Integer> values) {
            addCriterion("FYear not in", values, "fyear");
            return (Criteria) this;
        }

        public Criteria andFyearBetween(Integer value1, Integer value2) {
            addCriterion("FYear between", value1, value2, "fyear");
            return (Criteria) this;
        }

        public Criteria andFyearNotBetween(Integer value1, Integer value2) {
            addCriterion("FYear not between", value1, value2, "fyear");
            return (Criteria) this;
        }

        public Criteria andFperiodIsNull() {
            addCriterion("FPeriod is null");
            return (Criteria) this;
        }

        public Criteria andFperiodIsNotNull() {
            addCriterion("FPeriod is not null");
            return (Criteria) this;
        }

        public Criteria andFperiodEqualTo(Integer value) {
            addCriterion("FPeriod =", value, "fperiod");
            return (Criteria) this;
        }

        public Criteria andFperiodNotEqualTo(Integer value) {
            addCriterion("FPeriod <>", value, "fperiod");
            return (Criteria) this;
        }

        public Criteria andFperiodGreaterThan(Integer value) {
            addCriterion("FPeriod >", value, "fperiod");
            return (Criteria) this;
        }

        public Criteria andFperiodGreaterThanOrEqualTo(Integer value) {
            addCriterion("FPeriod >=", value, "fperiod");
            return (Criteria) this;
        }

        public Criteria andFperiodLessThan(Integer value) {
            addCriterion("FPeriod <", value, "fperiod");
            return (Criteria) this;
        }

        public Criteria andFperiodLessThanOrEqualTo(Integer value) {
            addCriterion("FPeriod <=", value, "fperiod");
            return (Criteria) this;
        }

        public Criteria andFperiodIn(List<Integer> values) {
            addCriterion("FPeriod in", values, "fperiod");
            return (Criteria) this;
        }

        public Criteria andFperiodNotIn(List<Integer> values) {
            addCriterion("FPeriod not in", values, "fperiod");
            return (Criteria) this;
        }

        public Criteria andFperiodBetween(Integer value1, Integer value2) {
            addCriterion("FPeriod between", value1, value2, "fperiod");
            return (Criteria) this;
        }

        public Criteria andFperiodNotBetween(Integer value1, Integer value2) {
            addCriterion("FPeriod not between", value1, value2, "fperiod");
            return (Criteria) this;
        }

        public Criteria andFhookidIsNull() {
            addCriterion("FHookID is null");
            return (Criteria) this;
        }

        public Criteria andFhookidIsNotNull() {
            addCriterion("FHookID is not null");
            return (Criteria) this;
        }

        public Criteria andFhookidEqualTo(Integer value) {
            addCriterion("FHookID =", value, "fhookid");
            return (Criteria) this;
        }

        public Criteria andFhookidNotEqualTo(Integer value) {
            addCriterion("FHookID <>", value, "fhookid");
            return (Criteria) this;
        }

        public Criteria andFhookidGreaterThan(Integer value) {
            addCriterion("FHookID >", value, "fhookid");
            return (Criteria) this;
        }

        public Criteria andFhookidGreaterThanOrEqualTo(Integer value) {
            addCriterion("FHookID >=", value, "fhookid");
            return (Criteria) this;
        }

        public Criteria andFhookidLessThan(Integer value) {
            addCriterion("FHookID <", value, "fhookid");
            return (Criteria) this;
        }

        public Criteria andFhookidLessThanOrEqualTo(Integer value) {
            addCriterion("FHookID <=", value, "fhookid");
            return (Criteria) this;
        }

        public Criteria andFhookidIn(List<Integer> values) {
            addCriterion("FHookID in", values, "fhookid");
            return (Criteria) this;
        }

        public Criteria andFhookidNotIn(List<Integer> values) {
            addCriterion("FHookID not in", values, "fhookid");
            return (Criteria) this;
        }

        public Criteria andFhookidBetween(Integer value1, Integer value2) {
            addCriterion("FHookID between", value1, value2, "fhookid");
            return (Criteria) this;
        }

        public Criteria andFhookidNotBetween(Integer value1, Integer value2) {
            addCriterion("FHookID not between", value1, value2, "fhookid");
            return (Criteria) this;
        }

        public Criteria andFidSrcIsNull() {
            addCriterion("FID_SRC is null");
            return (Criteria) this;
        }

        public Criteria andFidSrcIsNotNull() {
            addCriterion("FID_SRC is not null");
            return (Criteria) this;
        }

        public Criteria andFidSrcEqualTo(Integer value) {
            addCriterion("FID_SRC =", value, "fidSrc");
            return (Criteria) this;
        }

        public Criteria andFidSrcNotEqualTo(Integer value) {
            addCriterion("FID_SRC <>", value, "fidSrc");
            return (Criteria) this;
        }

        public Criteria andFidSrcGreaterThan(Integer value) {
            addCriterion("FID_SRC >", value, "fidSrc");
            return (Criteria) this;
        }

        public Criteria andFidSrcGreaterThanOrEqualTo(Integer value) {
            addCriterion("FID_SRC >=", value, "fidSrc");
            return (Criteria) this;
        }

        public Criteria andFidSrcLessThan(Integer value) {
            addCriterion("FID_SRC <", value, "fidSrc");
            return (Criteria) this;
        }

        public Criteria andFidSrcLessThanOrEqualTo(Integer value) {
            addCriterion("FID_SRC <=", value, "fidSrc");
            return (Criteria) this;
        }

        public Criteria andFidSrcIn(List<Integer> values) {
            addCriterion("FID_SRC in", values, "fidSrc");
            return (Criteria) this;
        }

        public Criteria andFidSrcNotIn(List<Integer> values) {
            addCriterion("FID_SRC not in", values, "fidSrc");
            return (Criteria) this;
        }

        public Criteria andFidSrcBetween(Integer value1, Integer value2) {
            addCriterion("FID_SRC between", value1, value2, "fidSrc");
            return (Criteria) this;
        }

        public Criteria andFidSrcNotBetween(Integer value1, Integer value2) {
            addCriterion("FID_SRC not between", value1, value2, "fidSrc");
            return (Criteria) this;
        }

        public Criteria andFentryidSrcIsNull() {
            addCriterion("FEntryID_SRC is null");
            return (Criteria) this;
        }

        public Criteria andFentryidSrcIsNotNull() {
            addCriterion("FEntryID_SRC is not null");
            return (Criteria) this;
        }

        public Criteria andFentryidSrcEqualTo(Integer value) {
            addCriterion("FEntryID_SRC =", value, "fentryidSrc");
            return (Criteria) this;
        }

        public Criteria andFentryidSrcNotEqualTo(Integer value) {
            addCriterion("FEntryID_SRC <>", value, "fentryidSrc");
            return (Criteria) this;
        }

        public Criteria andFentryidSrcGreaterThan(Integer value) {
            addCriterion("FEntryID_SRC >", value, "fentryidSrc");
            return (Criteria) this;
        }

        public Criteria andFentryidSrcGreaterThanOrEqualTo(Integer value) {
            addCriterion("FEntryID_SRC >=", value, "fentryidSrc");
            return (Criteria) this;
        }

        public Criteria andFentryidSrcLessThan(Integer value) {
            addCriterion("FEntryID_SRC <", value, "fentryidSrc");
            return (Criteria) this;
        }

        public Criteria andFentryidSrcLessThanOrEqualTo(Integer value) {
            addCriterion("FEntryID_SRC <=", value, "fentryidSrc");
            return (Criteria) this;
        }

        public Criteria andFentryidSrcIn(List<Integer> values) {
            addCriterion("FEntryID_SRC in", values, "fentryidSrc");
            return (Criteria) this;
        }

        public Criteria andFentryidSrcNotIn(List<Integer> values) {
            addCriterion("FEntryID_SRC not in", values, "fentryidSrc");
            return (Criteria) this;
        }

        public Criteria andFentryidSrcBetween(Integer value1, Integer value2) {
            addCriterion("FEntryID_SRC between", value1, value2, "fentryidSrc");
            return (Criteria) this;
        }

        public Criteria andFentryidSrcNotBetween(Integer value1, Integer value2) {
            addCriterion("FEntryID_SRC not between", value1, value2, "fentryidSrc");
            return (Criteria) this;
        }

        public Criteria andFbillnoSrcIsNull() {
            addCriterion("FBillNo_SRC is null");
            return (Criteria) this;
        }

        public Criteria andFbillnoSrcIsNotNull() {
            addCriterion("FBillNo_SRC is not null");
            return (Criteria) this;
        }

        public Criteria andFbillnoSrcEqualTo(String value) {
            addCriterion("FBillNo_SRC =", value, "fbillnoSrc");
            return (Criteria) this;
        }

        public Criteria andFbillnoSrcNotEqualTo(String value) {
            addCriterion("FBillNo_SRC <>", value, "fbillnoSrc");
            return (Criteria) this;
        }

        public Criteria andFbillnoSrcGreaterThan(String value) {
            addCriterion("FBillNo_SRC >", value, "fbillnoSrc");
            return (Criteria) this;
        }

        public Criteria andFbillnoSrcGreaterThanOrEqualTo(String value) {
            addCriterion("FBillNo_SRC >=", value, "fbillnoSrc");
            return (Criteria) this;
        }

        public Criteria andFbillnoSrcLessThan(String value) {
            addCriterion("FBillNo_SRC <", value, "fbillnoSrc");
            return (Criteria) this;
        }

        public Criteria andFbillnoSrcLessThanOrEqualTo(String value) {
            addCriterion("FBillNo_SRC <=", value, "fbillnoSrc");
            return (Criteria) this;
        }

        public Criteria andFbillnoSrcLike(String value) {
            addCriterion("FBillNo_SRC like", value, "fbillnoSrc");
            return (Criteria) this;
        }

        public Criteria andFbillnoSrcNotLike(String value) {
            addCriterion("FBillNo_SRC not like", value, "fbillnoSrc");
            return (Criteria) this;
        }

        public Criteria andFbillnoSrcIn(List<String> values) {
            addCriterion("FBillNo_SRC in", values, "fbillnoSrc");
            return (Criteria) this;
        }

        public Criteria andFbillnoSrcNotIn(List<String> values) {
            addCriterion("FBillNo_SRC not in", values, "fbillnoSrc");
            return (Criteria) this;
        }

        public Criteria andFbillnoSrcBetween(String value1, String value2) {
            addCriterion("FBillNo_SRC between", value1, value2, "fbillnoSrc");
            return (Criteria) this;
        }

        public Criteria andFbillnoSrcNotBetween(String value1, String value2) {
            addCriterion("FBillNo_SRC not between", value1, value2, "fbillnoSrc");
            return (Criteria) this;
        }

        public Criteria andFstandardidIsNull() {
            addCriterion("FStandardID is null");
            return (Criteria) this;
        }

        public Criteria andFstandardidIsNotNull() {
            addCriterion("FStandardID is not null");
            return (Criteria) this;
        }

        public Criteria andFstandardidEqualTo(Integer value) {
            addCriterion("FStandardID =", value, "fstandardid");
            return (Criteria) this;
        }

        public Criteria andFstandardidNotEqualTo(Integer value) {
            addCriterion("FStandardID <>", value, "fstandardid");
            return (Criteria) this;
        }

        public Criteria andFstandardidGreaterThan(Integer value) {
            addCriterion("FStandardID >", value, "fstandardid");
            return (Criteria) this;
        }

        public Criteria andFstandardidGreaterThanOrEqualTo(Integer value) {
            addCriterion("FStandardID >=", value, "fstandardid");
            return (Criteria) this;
        }

        public Criteria andFstandardidLessThan(Integer value) {
            addCriterion("FStandardID <", value, "fstandardid");
            return (Criteria) this;
        }

        public Criteria andFstandardidLessThanOrEqualTo(Integer value) {
            addCriterion("FStandardID <=", value, "fstandardid");
            return (Criteria) this;
        }

        public Criteria andFstandardidIn(List<Integer> values) {
            addCriterion("FStandardID in", values, "fstandardid");
            return (Criteria) this;
        }

        public Criteria andFstandardidNotIn(List<Integer> values) {
            addCriterion("FStandardID not in", values, "fstandardid");
            return (Criteria) this;
        }

        public Criteria andFstandardidBetween(Integer value1, Integer value2) {
            addCriterion("FStandardID between", value1, value2, "fstandardid");
            return (Criteria) this;
        }

        public Criteria andFstandardidNotBetween(Integer value1, Integer value2) {
            addCriterion("FStandardID not between", value1, value2, "fstandardid");
            return (Criteria) this;
        }

        public Criteria andFsrctaxamtforIsNull() {
            addCriterion("FSrcTaxAmtFor is null");
            return (Criteria) this;
        }

        public Criteria andFsrctaxamtforIsNotNull() {
            addCriterion("FSrcTaxAmtFor is not null");
            return (Criteria) this;
        }

        public Criteria andFsrctaxamtforEqualTo(BigDecimal value) {
            addCriterion("FSrcTaxAmtFor =", value, "fsrctaxamtfor");
            return (Criteria) this;
        }

        public Criteria andFsrctaxamtforNotEqualTo(BigDecimal value) {
            addCriterion("FSrcTaxAmtFor <>", value, "fsrctaxamtfor");
            return (Criteria) this;
        }

        public Criteria andFsrctaxamtforGreaterThan(BigDecimal value) {
            addCriterion("FSrcTaxAmtFor >", value, "fsrctaxamtfor");
            return (Criteria) this;
        }

        public Criteria andFsrctaxamtforGreaterThanOrEqualTo(BigDecimal value) {
            addCriterion("FSrcTaxAmtFor >=", value, "fsrctaxamtfor");
            return (Criteria) this;
        }

        public Criteria andFsrctaxamtforLessThan(BigDecimal value) {
            addCriterion("FSrcTaxAmtFor <", value, "fsrctaxamtfor");
            return (Criteria) this;
        }

        public Criteria andFsrctaxamtforLessThanOrEqualTo(BigDecimal value) {
            addCriterion("FSrcTaxAmtFor <=", value, "fsrctaxamtfor");
            return (Criteria) this;
        }

        public Criteria andFsrctaxamtforIn(List<BigDecimal> values) {
            addCriterion("FSrcTaxAmtFor in", values, "fsrctaxamtfor");
            return (Criteria) this;
        }

        public Criteria andFsrctaxamtforNotIn(List<BigDecimal> values) {
            addCriterion("FSrcTaxAmtFor not in", values, "fsrctaxamtfor");
            return (Criteria) this;
        }

        public Criteria andFsrctaxamtforBetween(BigDecimal value1, BigDecimal value2) {
            addCriterion("FSrcTaxAmtFor between", value1, value2, "fsrctaxamtfor");
            return (Criteria) this;
        }

        public Criteria andFsrctaxamtforNotBetween(BigDecimal value1, BigDecimal value2) {
            addCriterion("FSrcTaxAmtFor not between", value1, value2, "fsrctaxamtfor");
            return (Criteria) this;
        }

        public Criteria andFsrcnotaxamtforIsNull() {
            addCriterion("FSrcNoTaxAmtFor is null");
            return (Criteria) this;
        }

        public Criteria andFsrcnotaxamtforIsNotNull() {
            addCriterion("FSrcNoTaxAmtFor is not null");
            return (Criteria) this;
        }

        public Criteria andFsrcnotaxamtforEqualTo(BigDecimal value) {
            addCriterion("FSrcNoTaxAmtFor =", value, "fsrcnotaxamtfor");
            return (Criteria) this;
        }

        public Criteria andFsrcnotaxamtforNotEqualTo(BigDecimal value) {
            addCriterion("FSrcNoTaxAmtFor <>", value, "fsrcnotaxamtfor");
            return (Criteria) this;
        }

        public Criteria andFsrcnotaxamtforGreaterThan(BigDecimal value) {
            addCriterion("FSrcNoTaxAmtFor >", value, "fsrcnotaxamtfor");
            return (Criteria) this;
        }

        public Criteria andFsrcnotaxamtforGreaterThanOrEqualTo(BigDecimal value) {
            addCriterion("FSrcNoTaxAmtFor >=", value, "fsrcnotaxamtfor");
            return (Criteria) this;
        }

        public Criteria andFsrcnotaxamtforLessThan(BigDecimal value) {
            addCriterion("FSrcNoTaxAmtFor <", value, "fsrcnotaxamtfor");
            return (Criteria) this;
        }

        public Criteria andFsrcnotaxamtforLessThanOrEqualTo(BigDecimal value) {
            addCriterion("FSrcNoTaxAmtFor <=", value, "fsrcnotaxamtfor");
            return (Criteria) this;
        }

        public Criteria andFsrcnotaxamtforIn(List<BigDecimal> values) {
            addCriterion("FSrcNoTaxAmtFor in", values, "fsrcnotaxamtfor");
            return (Criteria) this;
        }

        public Criteria andFsrcnotaxamtforNotIn(List<BigDecimal> values) {
            addCriterion("FSrcNoTaxAmtFor not in", values, "fsrcnotaxamtfor");
            return (Criteria) this;
        }

        public Criteria andFsrcnotaxamtforBetween(BigDecimal value1, BigDecimal value2) {
            addCriterion("FSrcNoTaxAmtFor between", value1, value2, "fsrcnotaxamtfor");
            return (Criteria) this;
        }

        public Criteria andFsrcnotaxamtforNotBetween(BigDecimal value1, BigDecimal value2) {
            addCriterion("FSrcNoTaxAmtFor not between", value1, value2, "fsrcnotaxamtfor");
            return (Criteria) this;
        }
    }

    public static class Criteria extends GeneratedCriteria {

        protected Criteria() {
            super();
        }
    }

    public static class Criterion {
        private String condition;

        private Object value;

        private Object secondValue;

        private boolean noValue;

        private boolean singleValue;

        private boolean betweenValue;

        private boolean listValue;

        private String typeHandler;

        public String getCondition() {
            return condition;
        }

        public Object getValue() {
            return value;
        }

        public Object getSecondValue() {
            return secondValue;
        }

        public boolean isNoValue() {
            return noValue;
        }

        public boolean isSingleValue() {
            return singleValue;
        }

        public boolean isBetweenValue() {
            return betweenValue;
        }

        public boolean isListValue() {
            return listValue;
        }

        public String getTypeHandler() {
            return typeHandler;
        }

        protected Criterion(String condition) {
            super();
            this.condition = condition;
            this.typeHandler = null;
            this.noValue = true;
        }

        protected Criterion(String condition, Object value, String typeHandler) {
            super();
            this.condition = condition;
            this.value = value;
            this.typeHandler = typeHandler;
            if (value instanceof List<?>) {
                this.listValue = true;
            } else {
                this.singleValue = true;
            }
        }

        protected Criterion(String condition, Object value) {
            this(condition, value, null);
        }

        protected Criterion(String condition, Object value, Object secondValue, String typeHandler) {
            super();
            this.condition = condition;
            this.value = value;
            this.secondValue = secondValue;
            this.typeHandler = typeHandler;
            this.betweenValue = true;
        }

        protected Criterion(String condition, Object value, Object secondValue) {
            this(condition, value, secondValue, null);
        }
    }
}