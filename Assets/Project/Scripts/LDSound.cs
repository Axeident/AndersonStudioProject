using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LDSound : MonoBehaviour
{
    private AudioSource makeSound;
    public AudioSource DarkSoundSource;
    public AudioSource LightSoundSource;

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
            DarkSoundSource.clip = LookTowardDark;
            DarkSoundSource.Play();
            hasLookedDark = true;
        }
        if(!hasLookedLight && !PlayDark)
        {
            LightSoundSource.clip = LookTowardLight;
            LightSoundSource.Play();
            hasLookedLight = true;
        }
    }

    public void PlayAwaySound(bool PlayDark)
    {
        if (!hasAwayDark && PlayDark)
        {
            DarkSoundSource.clip = LookAwayDark;
            DarkSoundSource.Play();
            hasAwayDark = true;
        }
        if (!hasAwayLight && !PlayDark)
        {
            LightSoundSource.clip = LookAwayLight;
            LightSoundSource.Play();
            hasAwayLight = true;
        }
    }

    public void PlayChoseSound(bool PlayDark)
    {
        if (!hasChosenDark && PlayDark)
        {
            DarkSoundSource.clip = ChoseDark;
            DarkSoundSource.Play();
            hasChosenDark = true;
        }
        if (!hasChosenLight && !PlayDark)
        {
            LightSoundSource.clip = ChoseLight;
            LightSoundSource.Play();
            hasChosenLight = true;
        }
    }
}
