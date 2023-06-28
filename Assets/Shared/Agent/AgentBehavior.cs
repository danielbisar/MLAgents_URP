using System;
using System.Diagnostics;
using TreeEditor;
using Unity.MLAgents;
using Unity.MLAgents.Actuators;
using Unity.MLAgents.Sensors;
using UnityEngine;
using Debug = UnityEngine.Debug;

public class AgentBehavior : Agent
{
    public static int HighScore = 0;
    public static float HighestReward = 0;
    
    public float MoveForce = 50;
    public float MaxSpeedMpS = 3;
    public float SpawnTailS = 0.05f;
    private float _sqrMaxSpeed;

    private Rigidbody _rigidbody;
    private int _collectedTargets;
    private float _lastDistance;
    
    public TargetBehavior TargetBehavior { get; set; }

    private AgentTailBehavior _agentTailBehavior;
    private float _tailSpawnTime;

    private void Start()
    {
        _rigidbody = GetComponent<Rigidbody>();
        _sqrMaxSpeed = MaxSpeedMpS*MaxSpeedMpS;
        _agentTailBehavior = transform.parent.GetComponentInChildren<AgentTailBehavior>();
        _agentTailBehavior.GetComponent<MeshRenderer>().enabled = false; // do not render the original
    }

    public override void OnEpisodeBegin()
    {
        transform.localPosition = new Vector3(0, transform.localPosition.y, 0);
        _rigidbody.ResetInertiaTensor();
        _tailSpawnTime = Time.time;
        
        _lastDistance = float.PositiveInfinity;
        _collectedTargets = 0;
    }
    
    public override void CollectObservations(VectorSensor sensor)
    {
        sensor.AddObservation(transform.localPosition);
        sensor.AddObservation(TargetBehavior.transform.localPosition);
        sensor.AddObservation(Vector3.Distance(transform.localPosition, TargetBehavior.transform.localPosition));
    }

    public override void OnActionReceived(ActionBuffers actions)
    {
        var forwardBackward = actions.DiscreteActions[0];
        var rightLeft = actions.DiscreteActions[1];
        var moveVector = new Vector3();

        if (forwardBackward != 0)
        {
            if (forwardBackward == 1)
                moveVector.x -= 1;
            else if(forwardBackward == 2)
                moveVector.x += 1;
        }
        
        if (rightLeft != 0)
        {
            if (rightLeft == 1)
                moveVector.z -= 1;
            else if(rightLeft == 2)
                moveVector.z += 1;
        }
        
        // calculation of the vector square is faster than calculating the root
        // so we just compare with the _sqrMaxSpeed
        // see: https://docs.unity3d.com/2022.2/Documentation/ScriptReference/Vector3-sqrMagnitude.html
        if(_rigidbody.velocity.sqrMagnitude < _sqrMaxSpeed)
            _rigidbody.AddForce(moveVector * MoveForce);

        var distance = Vector3.Distance(transform.localPosition, TargetBehavior.transform.localPosition);

        if (distance < _lastDistance)
        {
            AddReward(0.00001f);
        }
        else if (distance > _lastDistance)
        {
            AddReward(-0.00001f);
        }

        _lastDistance = distance;

        if (Time.time - _tailSpawnTime > SpawnTailS)
        {
            var box = Instantiate(_agentTailBehavior.gameObject, transform.parent);
            box.transform.localPosition = transform.localPosition;
            box.GetComponent<AgentTailBehavior>().IsOriginal = false;
            box.GetComponent<MeshRenderer>().enabled = true;
            _tailSpawnTime = Time.time;
        }
    }

    public override void Heuristic(in ActionBuffers actionsOut)
    {
        var discreteActions = actionsOut.DiscreteActions;
        discreteActions[0] = GetDiscreteValue(Input.GetAxis("Horizontal"));
        discreteActions[1] = GetDiscreteValue(Input.GetAxis("Vertical"));
    }

    private int GetDiscreteValue(float value)
    {
        var deadZone = 0.02f;

        if (MathF.Abs(value) < deadZone)
            return 0;

        if (value < 0)
            return 1;
        
        //if (value > 0)
        return 2;
    }

    public void CollectedTarget()
    {
        _collectedTargets++;
        AddReward(1f);

        if (_collectedTargets > HighScore)
        {
            HighScore = _collectedTargets;
            Debug.Log("New HighScore: " + _collectedTargets);
        }

        if (GetCumulativeReward() > HighestReward)
        {
            HighestReward = GetCumulativeReward();
            Debug.Log("New Highest Reward: " + HighestReward);
        }
    }
}
