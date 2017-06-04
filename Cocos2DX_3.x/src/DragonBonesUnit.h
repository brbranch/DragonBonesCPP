//
//  DragonBonesUnit.h
//  LazerGun
//
//  Created by Kazuki Oda on 2017/06/01.
//
//

#ifndef DragonBonesUnit_h
#define DragonBonesUnit_h
#include "cocos2d.h"
#include "dragonBones/cocos2dx/CCDragonBonesHeaders.h"

class DragonBonesBase : public cocos2d::Ref {
   public:
    DragonBonesBase();
    virtual ~DragonBonesBase();
    virtual void update(float f){};
};

template <class T>
class DragonBonesUnit : public DragonBonesBase {
   private:
    dragonBones::CCFactory m_factory;
    CC_SYNTHESIZE_READONLY(dragonBones::DragonBonesData*, m_data, Data);
    CC_SYNTHESIZE_READONLY(dragonBones::CCArmatureDisplay*, m_node, Node);
    CC_SYNTHESIZE_READONLY(dragonBones::Armature*, m_root, Root);

   public:
    DragonBonesUnit()
        : m_factory(), m_data(nullptr), m_node(nullptr), m_root(nullptr) {
    }
    virtual ~DragonBonesUnit() {
        if (m_root) {
            dragonBones::WorldClock::clock.remove(m_root);
            m_root->dispose();
        }
        CC_SAFE_RELEASE_NULL(m_node);
    }

    static cocos2d::RefPtr<T> createWithData(const std::string& ske,
                                             const std::string& tex,
                                             const std::string& armature) {
        cocos2d::RefPtr<T> ptr;
        ptr.weakAssign(new T());
        if (ptr && ptr->initWithData(ske, tex, armature)) {
            return ptr;
        }
        return nullptr;
    }

    void action(const std::string& actionName, int time = -1) {
        if (m_root == nullptr) return;
        m_root->getAnimation().play(actionName, time);
    }

   protected:
    virtual bool initWithData(const std::string& ske, const std::string& tex,
                              const std::string& armature) {
        m_data = m_factory.loadDragonBonesData(ske);
        m_factory.loadTextureAtlasData(tex);
        m_root = m_factory.buildArmature(armature);
        m_node =
            dynamic_cast<dragonBones::CCArmatureDisplay*>(m_root->getDisplay());
        m_node->retain();
        dragonBones::WorldClock::clock.add(m_root);
        return true;
    }

    virtual bool init() {
        return false;
    }
};

class CCDragonBones : public DragonBonesUnit<CCDragonBones> {
   public:
};

#endif /* DragonBonesUnit_h */
