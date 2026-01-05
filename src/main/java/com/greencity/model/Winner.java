package com.greencity.model;

import java.sql.Timestamp;

public class Winner {
    private int ticketId;
    private int applicantId;
    private long seed;
    private Timestamp drawTime;

    public Winner() {}

    public Winner(int ticketId, int applicantId, long seed, Timestamp drawTime) {
        this.ticketId = ticketId;
        this.applicantId = applicantId;
        this.seed = seed;
        this.drawTime = drawTime;
    }

    public int getTicketId() {
        return ticketId;
    }

    public void setTicketId(int ticketId) {
        this.ticketId = ticketId;
    }

    public int getApplicantId() {
        return applicantId;
    }

    public void setApplicantId(int applicantId) {
        this.applicantId = applicantId;
    }

    public long getSeed() {
        return seed;
    }

    public void setSeed(long seed) {
        this.seed = seed;
    }

    public Timestamp getDrawTime() {
        return drawTime;
    }

    public void setDrawTime(Timestamp drawTime) {
        this.drawTime = drawTime;
    }
}
