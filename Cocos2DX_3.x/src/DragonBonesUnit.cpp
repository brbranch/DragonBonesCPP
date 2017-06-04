//
//  DragonBonesUnit.cpp
//  LazerGun
//
//  Created by Kazuki Oda on 2017/06/01.
//
//

#include "DragonBonesUnit.h"
#include "DragonBonesPool.h"
DragonBonesBase::DragonBonesBase() {
    DragonBonesPool::getInstance()->add(this);
}

DragonBonesBase::~DragonBonesBase() {
    DragonBonesPool::getInstance()->remove(this);
}
