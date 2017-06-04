//
//  DragonBonesPool.hpp
//  LazerGun
//
//  Created by Kazuki Oda on 2017/06/01.
//
//

#ifndef DragonBonesPool_hpp
#define DragonBonesPool_hpp

#include "DragonBonesUnit.h"
#include "cocos2d.h"

class DragonBonesPool {
   private:
    bool m_running = false;
    cocos2d::Vector<DragonBonesBase*> m_pool;

   public:
    static DragonBonesPool* getInstance();
    static void dispose();
    void add(DragonBonesBase* base);
    void remove(DragonBonesBase* base);
    void start();
    void stop();
    void pause();
    void resume();

   private:
    void update(float f);
    DragonBonesPool();
    virtual ~DragonBonesPool();
};

#endif /* DragonBonesPool_hpp */
