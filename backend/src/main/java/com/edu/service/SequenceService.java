package com.edu.service;

import com.edu.entity.sequence.Sequence;
import com.github.jeffreyning.mybatisplus.service.IMppService;

public interface SequenceService extends IMppService<Sequence> {
    String generateUserId(int year, String role);
}
