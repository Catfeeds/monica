package com.fh.entity;

import java.math.BigDecimal;

public class ExpInvoiceDistribute {
    private Integer fid;

    private Integer fyear;

    private Integer fperiod;

    private Integer fhookid;

    private Integer fidSrc;

    private Integer fentryidSrc;

    private String fbillnoSrc;

    private Integer fstandardid;

    private BigDecimal fsrctaxamtfor;

    private BigDecimal fsrcnotaxamtfor;

    public Integer getFid() {
        return fid;
    }

    public void setFid(Integer fid) {
        this.fid = fid;
    }

    public Integer getFyear() {
        return fyear;
    }

    public void setFyear(Integer fyear) {
        this.fyear = fyear;
    }

    public Integer getFperiod() {
        return fperiod;
    }

    public void setFperiod(Integer fperiod) {
        this.fperiod = fperiod;
    }

    public Integer getFhookid() {
        return fhookid;
    }

    public void setFhookid(Integer fhookid) {
        this.fhookid = fhookid;
    }

    public Integer getFidSrc() {
        return fidSrc;
    }

    public void setFidSrc(Integer fidSrc) {
        this.fidSrc = fidSrc;
    }

    public Integer getFentryidSrc() {
        return fentryidSrc;
    }

    public void setFentryidSrc(Integer fentryidSrc) {
        this.fentryidSrc = fentryidSrc;
    }

    public String getFbillnoSrc() {
        return fbillnoSrc;
    }

    public void setFbillnoSrc(String fbillnoSrc) {
        this.fbillnoSrc = fbillnoSrc == null ? null : fbillnoSrc.trim();
    }

    public Integer getFstandardid() {
        return fstandardid;
    }

    public void setFstandardid(Integer fstandardid) {
        this.fstandardid = fstandardid;
    }

    public BigDecimal getFsrctaxamtfor() {
        return fsrctaxamtfor;
    }

    public void setFsrctaxamtfor(BigDecimal fsrctaxamtfor) {
        this.fsrctaxamtfor = fsrctaxamtfor;
    }

    public BigDecimal getFsrcnotaxamtfor() {
        return fsrcnotaxamtfor;
    }

    public void setFsrcnotaxamtfor(BigDecimal fsrcnotaxamtfor) {
        this.fsrcnotaxamtfor = fsrcnotaxamtfor;
    }
}