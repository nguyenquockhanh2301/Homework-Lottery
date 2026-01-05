package com.greencity.service;

import com.greencity.model.Applicant;

import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class LotteryService {

    public List<Applicant> draw(List<Applicant> applicants, int winnersCount, Long seed) {
        if (applicants == null) return Collections.emptyList();
        List<Applicant> copy = new ArrayList<>(applicants);
        SecureRandom rnd = null;
        if (seed != null) {
            try {
                // Use a deterministic algorithm when a seed is supplied
                rnd = SecureRandom.getInstance("SHA1PRNG");
            } catch (Exception e) {
                rnd = new SecureRandom();
            }
            rnd.setSeed(seed);
        } else {
            try {
                rnd = SecureRandom.getInstanceStrong();
            } catch (Exception e) {
                rnd = new SecureRandom();
            }
        }

        // Fisher-Yates shuffle
        for (int i = copy.size() - 1; i > 0; i--) {
            int j = rnd.nextInt(i + 1);
            Applicant tmp = copy.get(i);
            copy.set(i, copy.get(j));
            copy.set(j, tmp);
        }

        if (winnersCount >= copy.size()) return copy;
        return new ArrayList<>(copy.subList(0, winnersCount));
    }
}
