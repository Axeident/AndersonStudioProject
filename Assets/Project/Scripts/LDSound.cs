using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LDSound : MonoBehaviour
{
    private AudioSource makeSound;
    private AudioSource DarkTrigger;
    private AudioSource LightTrigger;

    public AudioClip LookTowardLight;
    private bool hasLookedLight;

    public AudioClip LookTowardDark;
    private bool hasLookedDark;

    public AudioClip IntroSound;
    public float PlayIntroTime;
    private float IntroPlaying;
    private bool BeginIntro = false;
    private bool PlayedIntro = false;

    public AudioClip LookAwayLight;
    private bool hasAwayLight;

    public AudioClip LookAwayDark;
    private bool hasAwayDark;

    public AudioClip ChoseLight;
    private bool hasChosenLight;

    public AudioClip ChoseDark;
    private bool hasChosenDark;

    // Start is called before the first frame update
    void Awake()
    {
        PlayedIntro = false;
        BeginIntro = true;
        IntroPlaying = 0.0f;

        hasAwayDark = false;
        hasAwayLight = false;
        hasLookedDark = false;
        hasLookedLight = false;
        hasChosenDark = false;
        hasChosenLight = false;

        makeSound = GetComponent<AudioSource>();
        
        foreach(Transform searchChild in transform)
        {
            if(searchChild.CompareTag("TriggerOne"))
            {
                LightTrigger = searchChild.GetComponent<AudioSource>();
            }
            if(searchChild.CompareTag("TriggerTwo"))
            {
                DarkTrigger = searchChild.GetComponent<AudioSource>();
            }
        }
    }

    // Update is called once per frame
    void Update()
    {
        if(BeginIntro && !PlayedIntro)
        {
            IntroPlaying += Time.deltaTime;
            if(IntroPlaying >= PlayIntroTime)
            {
                //Play IntroAudio
                makeSound.clip = IntroSound;
                makeSound.Play();
                PlayedIntro = true;
            }
        }
    }

    public void PlayLookSound(bool PlayDark)
    {
        if(!hasLookedDark && PlayDark)
        {
            DarkTrigger.clip = LookTowardDark;
            DarkTrigger.Play();
            hasLookedDark = true;
        }
        if(!hasLookedLight && !PlayDark)
        {
            LightTrigger.clip = LookTowardLight;
            LightTrigger.Play();
            hasLookedLight = true;
        }
    }

    public void PlayAwaySound(bool PlayDark)
    {
        if (!hasAwayDark && PlayDark)
        {
            DarkTrigger.clip = LookAwayDark;
            DarkTrigger.Play();
            hasAwayDark = true;
        }
        if (!hasAwayLight && !PlayDark)
        {
            LightTrigger.clip = LookAwayLight;
            LightTrigger.Play();
            hasAwayLight = true;
        }
    }

    public void PlayChoseSound(bool PlayDark)
    {
        if (!hasChosenDark && PlayDark)
        {
            DarkTrigger.clip = ChoseDark;
            DarkTrigger.Play();
            hasChosenDark = true;
        }
        if (!hasChosenLight && !PlayDark)
        {
            LightTrigger.clip = ChoseLight;
            LightTrigger.Play();
            hasChosenLight = true;
        }
    }
}
