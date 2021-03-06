#pragma once
#include "IncClient.h"
#include "GlmMath.h"

class TextLayer : public boo::Layer
{
private:
    GlmMath glmObj;

public:
    TextLayer()
        : Layer("Texture")
    {
        auto cam = glmObj.Camera(5.0f, { 0.5f, 0.5f });
    }

    void OnUpdate() override
    {
        //BOO_CLIENT_INFO("TextLayer::Update");

        if (boo::InputMgr::IsKeyPressed(BOO_KEY_TAB))
        {
            BOO_CLIENT_TRACE("Tab Key is Pressed (poll)!");
        }
    }

    void OnEvent(boo::Event& onEvent) override
    {
        //ON_CLIENT_TRACE("{0}", event);

        if (onEvent.GetEventType() == boo::EventType::KeyPressed)
        {
            boo::KeyPressedEvent& evt = (boo::KeyPressedEvent&)onEvent;
            if (evt.GetKeyCode() == BOO_KEY_W)
                BOO_CLIENT_TRACE("Player are Walking Up (event)!");
            BOO_CLIENT_TRACE("{0}", (char)evt.GetKeyCode());
        }
    }
};

class GuiLayer : public boo::Layer
{
public:
    GuiLayer()
        : Layer("GuI_Layer")
    {
    }

    void OnUpdate() override
    {
        BOO_CLIENT_INFO("GuiLayer::Update");

        /*if (boo::ImputMgr::IsKeyPressed(ON_KEY_TAB))
        {
            BOO_CLIENT_TRACE("Tab Key is Pressed (poll)!");
        }*/
    }

    void OnEvent(boo::Event& onEvent) override
    {
        //BOO_CLIENT_TRACE("{0}", onEvent);

        /*if (onEvent.GetEventType() == boo::EventType::KeyPressed)
        {
            boo::KeyPressedEvent& evt = (boo::KeyPressedEvent&)onEvent;
            if (evt.GetKeyCode() == BOO_KEY_W)
                BOO_CLIENT_TRACE("Player are Walking Up (event)!");
            BOO_CLIENT_TRACE("{0}", (char)evt.GetKeyCode());
        }*/
    }
};

class ImgLayer : public boo::Layer
{
public:
    ImgLayer()
        : Layer("ImgLayer")
    {
    }

    void OnUpdate() override
    {
        //BOO_CLIENT_INFO("ImgLayer::Update");

        /*if (boo::ImputMgr::IsKeyPressed(ON_KEY_TAB))
        {
            BOO_CLIENT_TRACE("Tab Key is Pressed (poll)!");
        }*/
    }

    void OnEvent(boo::Event& onEvent) override
    {
        //BOO_CLIENT_TRACE("{0}", onEvent);

        /*if (onEvent.GetEventType() == boo::EventType::KeyPressed)
        {
            boo::KeyPressedEvent& evt = (boo::KeyPressedEvent&)onEvent;
            if (evt.GetKeyCode() == BOO_KEY_W)
                BOO_CLIENT_TRACE("Player are Walking Up (event)!");
            BOO_CLIENT_TRACE("{0}", (char)evt.GetKeyCode());
        }*/
    }
};

class LayerList
{
public:
    LayerList();
    ~LayerList();
};

