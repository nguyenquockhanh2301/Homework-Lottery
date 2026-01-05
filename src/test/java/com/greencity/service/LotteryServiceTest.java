package com.greencity.service;

import com.greencity.model.Applicant;
import org.junit.jupiter.api.Test;

import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

public class LotteryServiceTest {

    @Test
    public void testDrawSizeAndDeterminism() {
        List<Applicant> applicants = new ArrayList<>();
        for (int i = 1; i <= 1200; i++) {
            applicants.add(new Applicant(i, "A" + i, "valid"));
        }

        LotteryService svc = new LotteryService();
        long seed = 123456789L;
        List<Applicant> winners1 = svc.draw(applicants, 500, seed);
        List<Applicant> winners2 = svc.draw(applicants, 500, seed);

        assertEquals(500, winners1.size());
        assertEquals(500, winners2.size());
        // With same seed, order should be identical
        for (int i = 0; i < 500; i++) {
            assertEquals(winners1.get(i).getId(), winners2.get(i).getId());
        }
    }
}
