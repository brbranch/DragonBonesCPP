//
//  DragonBonesPool.cpp
//  LazerGun
//
//  Created by Kazuki Oda on 2017/06/01.
//
//

#include "DragonBonesPool.h"
static DragonBonesPool* s_instance = nullptr;

DragonBonesPool::DragonBonesPool() : m_pool(), m_running(false){};
DragonBonesPool::~DragonBonesPool() {
    stop();
}

DragonBonesPool* DragonBonesPool::getInstance() {
    if (s_instance == nullptr) {
        s_instance = new DragonBonesPool;
        s_instance->start();
    }
    return s_instance;
}

void DragonBonesPool::dispose() {
    if (s_instance) {
        delete s_instance;
        s_instance = nullptr;
    }
}

void DragonBonesPool::add(DragonBonesBase* base) {
    m_pool.pushBack(base);
}

void DragonBonesPool::remove(DragonBonesBase* base) {
    m_pool.eraseObject(base);
}

void DragonBonesPool::start() {
    resume();
    auto director = cocos2d::Director::getInstance();
    auto scheduler = director->getScheduler();
    if (scheduler->isScheduled("update", this)) {
        return;
    }
    auto callback = CC_CALLBACK_1(DragonBonesPool::update, this);
    scheduler->schedule(callback, this, 0.f, UINT_MAX, 0.f, false, "update");
}

void DragonBonesPool::stop() {
    pause();
    auto director = cocos2d::Director::getInstance();
    auto scheduler = director->getScheduler();
    if (!scheduler->isScheduled("update", this)) {
        return;
    }
    scheduler->unschedule("update", this);
}

void DragonBonesPool::pause() {
    m_running = false;
}

void DragonBonesPool::resume() {
    m_running = true;
}

void DragonBonesPool::update(float f) {
    if (!m_running) return;
    auto list = m_pool;
    for (auto& l : list) {
        l->update(f);
    }
    dragonBones::WorldClock::clock.advanceTime(f);
}
